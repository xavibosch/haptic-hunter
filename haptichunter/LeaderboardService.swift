import Foundation
import Security
import Combine

struct LeaderboardEntry: Codable, Identifiable {
    let id: UUID
    let displayName: String
    let score: Int
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case score
        case createdAt = "created_at"
    }
}

private struct SupabaseSession: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresAt: TimeInterval
    let user: SupabaseUser

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
        case user
    }
}

private struct SupabaseUser: Codable {
    let id: UUID
}

private enum LeaderboardError: LocalizedError {
    case notConfigured
    case invalidResponse
    case server(String)
    case missingSession

    var errorDescription: String? {
        switch self {
        case .notConfigured:
            return "Supabase no está configurado. Añade SUPABASE_URL y SUPABASE_PUBLISHABLE_KEY en Info.plist."
        case .invalidResponse:
            return "El servidor devolvió una respuesta no válida."
        case .server(let message):
            return message
        case .missingSession:
            return "Inicia sesión para participar."
        }
    }
}

private enum SupabaseConfiguration {
    static var url: URL? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_URL") as? String,
              !value.contains("YOUR_PROJECT"),
              let url = URL(string: value) else { return nil }
        return url
    }

    static var publishableKey: String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "SUPABASE_PUBLISHABLE_KEY") as? String,
              !value.isEmpty,
              !value.contains("YOUR_PUBLISHABLE") else { return nil }
        return value
    }
}

private enum SessionKeychain {
    static let service = "com.xbapp.haptichunter.supabase"
    static let account = "session"

    static func load() -> SupabaseSession? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &result) == errSecSuccess,
              let data = result as? Data else { return nil }
        return try? JSONDecoder().decode(SupabaseSession.self, from: data)
    }

    static func save(_ session: SupabaseSession) throws {
        let data = try JSONEncoder().encode(session)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        let attributes: [String: Any] = [
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        if status == errSecItemNotFound {
            var insert = query
            attributes.forEach { insert[$0.key] = $0.value }
            guard SecItemAdd(insert as CFDictionary, nil) == errSecSuccess else {
                throw LeaderboardError.invalidResponse
            }
        } else if status != errSecSuccess {
            throw LeaderboardError.invalidResponse
        }
    }

    static func clear() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}

@MainActor
final class LeaderboardService: ObservableObject {
    @Published private(set) var entries: [LeaderboardEntry] = []
    @Published private(set) var isLoading = false
    @Published private(set) var isAuthenticated = SessionKeychain.load() != nil
    @Published var errorMessage: String?
    @Published var confirmationMessage: String?

    private var session = SessionKeychain.load()
    private let encoder = JSONEncoder()
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    static var currentEventID: String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return "daily-\(formatter.string(from: Date()))"
    }

    func loadEntries() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let event = Self.currentEventID.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? Self.currentEventID
            let request = try makeRequest(
                path: "/rest/v1/leaderboard_entries?select=id,display_name,score,created_at&event_id=eq.\(event)&order=score.desc,created_at.asc&limit=100"
            )
            let data = try await execute(request)
            entries = try decoder.decode([LeaderboardEntry].self, from: data)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signInWithApple(idToken: String, nonce: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            var request = try makeRequest(path: "/auth/v1/token?grant_type=id_token", method: "POST")
            request.httpBody = try encoder.encode(AppleIDTokenRequest(
                provider: "apple",
                idToken: idToken,
                nonce: nonce
            ))
            let data = try await execute(request)
            let newSession = try decoder.decode(SupabaseSession.self, from: data)
            try SessionKeychain.save(newSession)
            session = newSession
            isAuthenticated = true
            confirmationMessage = "Sesión iniciada con Apple. Ya puedes participar."
            errorMessage = nil
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func submit(score: Int, displayName: String) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        do {
            let activeSession = try await validSession()
            var request = try makeRequest(path: "/rest/v1/leaderboard_entries?on_conflict=event_id,user_id", method: "POST", accessToken: activeSession.accessToken)
            request.setValue("resolution=merge-duplicates,return=minimal", forHTTPHeaderField: "Prefer")
            request.httpBody = try encoder.encode(ScoreSubmission(
                eventID: Self.currentEventID,
                userID: activeSession.user.id,
                displayName: sanitizedName(displayName),
                score: max(0, score)
            ))
            _ = try await execute(request)
            confirmationMessage = "Puntuación enviada."
            errorMessage = nil
            await loadEntries()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func signOut() {
        session = nil
        isAuthenticated = false
        SessionKeychain.clear()
    }

    private func validSession() async throws -> SupabaseSession {
        guard let session else { throw LeaderboardError.missingSession }
        if session.expiresAt > Date().timeIntervalSince1970 + 60 { return session }

        var request = try makeRequest(path: "/auth/v1/token?grant_type=refresh_token", method: "POST")
        request.httpBody = try encoder.encode(["refresh_token": session.refreshToken])
        let data = try await execute(request)
        let refreshed = try decoder.decode(SupabaseSession.self, from: data)
        try SessionKeychain.save(refreshed)
        self.session = refreshed
        return refreshed
    }

    private func makeRequest(path: String, method: String = "GET", accessToken: String? = nil) throws -> URLRequest {
        guard let baseURL = SupabaseConfiguration.url,
              let key = SupabaseConfiguration.publishableKey,
              let url = URL(string: path, relativeTo: baseURL) else { throw LeaderboardError.notConfigured }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.timeoutInterval = 15
        request.setValue(key, forHTTPHeaderField: "apikey")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return request
    }

    private func execute(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let http = response as? HTTPURLResponse else { throw LeaderboardError.invalidResponse }
        guard 200..<300 ~= http.statusCode else {
            let payload = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any]
            let message = payload?["msg"] as? String
                ?? payload?["message"] as? String
                ?? payload?["error_description"] as? String
                ?? "Error del servidor (\(http.statusCode))."
            throw LeaderboardError.server(message)
        }
        return data
    }

    private func sanitizedName(_ name: String) -> String {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return String((trimmed.isEmpty ? "Hunter" : trimmed).prefix(24))
    }
}

private struct ScoreSubmission: Encodable {
    let eventID: String
    let userID: UUID
    let displayName: String
    let score: Int

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case userID = "user_id"
        case displayName = "display_name"
        case score
    }
}

private struct AppleIDTokenRequest: Encodable {
    let provider: String
    let idToken: String
    let nonce: String

    enum CodingKeys: String, CodingKey {
        case provider
        case idToken = "id_token"
        case nonce
    }
}
