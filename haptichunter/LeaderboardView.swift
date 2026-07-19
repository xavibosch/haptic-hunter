import SwiftUI
import AuthenticationServices
import CryptoKit
import Security

struct LeaderboardView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var service: LeaderboardService
    let score: Int
    let language: AppLanguage

    @AppStorage("leaderboardDisplayName") private var displayName = ""
    @State private var currentNonce: String?
    @State private var appleError: String?

    private var isSpanish: Bool { language == .es }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 16) {
                    eventHeader
                    leaderboardList
                    participationPanel
                }
                .padding()
            }
            .foregroundStyle(.white)
            .navigationTitle(isSpanish ? "CLASIFICACIÓN" : "LEADERBOARD")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isSpanish ? "Cerrar" : "Close") { dismiss() }
                }
            }
            .task { await service.loadEntries() }
            .refreshable { await service.loadEntries() }
        }
        .preferredColorScheme(.dark)
    }

    private var eventHeader: some View {
        HStack {
            Image(systemName: "calendar.badge.clock").foregroundStyle(.cyan)
            VStack(alignment: .leading) {
                Text(isSpanish ? "RETO DIARIO" : "DAILY EVENT").font(.headline)
                Text(LeaderboardService.currentEventID).font(.caption.monospaced()).foregroundStyle(.secondary)
            }
            Spacer()
            if service.isLoading { ProgressView() }
        }
    }

    private var leaderboardList: some View {
        Group {
            if service.entries.isEmpty && !service.isLoading {
                ContentUnavailableView(
                    isSpanish ? "Sin puntuaciones" : "No scores yet",
                    systemImage: "list.number",
                    description: Text(isSpanish ? "Sé la primera persona en participar." : "Be the first person to join.")
                )
            } else {
                List(Array(service.entries.enumerated()), id: \.element.id) { index, entry in
                    HStack {
                        Text("#\(index + 1)").font(.headline.monospacedDigit()).frame(width: 42, alignment: .leading)
                        Text(entry.displayName).lineLimit(1)
                        Spacer()
                        Text("\(entry.score)").font(.headline.monospacedDigit()).foregroundStyle(.cyan)
                    }
                    .listRowBackground(Color.white.opacity(0.05))
                }
                .listStyle(.plain)
            }
        }
        .frame(maxHeight: .infinity)
    }

    @ViewBuilder
    private var participationPanel: some View {
        VStack(spacing: 10) {
            if service.isAuthenticated {
                TextField(isSpanish ? "Nombre público" : "Public name", text: $displayName)
                    .textInputAutocapitalization(.words)
                    .textFieldStyle(.roundedBorder)

                Button {
                    Task { _ = await service.submit(score: score, displayName: displayName) }
                } label: {
                    Label(
                        isSpanish ? "ENVIAR \(score) PUNTOS" : "SUBMIT \(score) POINTS",
                        systemImage: "paperplane.fill"
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.cyan)
                .disabled(service.isLoading)

                Button(isSpanish ? "Cerrar sesión" : "Sign out", role: .destructive) { service.signOut() }
                    .font(.caption)
            } else {
                Text(isSpanish
                     ? "Puedes consultar la clasificación sin cuenta. Usa Apple solo si quieres participar."
                     : "Viewing is public. Use Apple only when you want to participate.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                SignInWithAppleButton(.signIn) { request in
                    let nonce = Self.randomNonceString()
                    currentNonce = nonce
                    request.requestedScopes = [.email]
                    request.nonce = Self.sha256(nonce)
                } onCompletion: { result in
                    handleAppleCompletion(result)
                }
                .signInWithAppleButtonStyle(.white)
                .frame(height: 50)
                .disabled(service.isLoading)
            }

            if let message = service.confirmationMessage {
                Text(message).font(.caption).foregroundStyle(.green)
            }
            if let error = service.errorMessage {
                Text(error).font(.caption).foregroundStyle(.red).multilineTextAlignment(.center)
            }
            if let appleError {
                Text(appleError).font(.caption).foregroundStyle(.red).multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(Color.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 12))
    }

    private func handleAppleCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
                  let tokenData = credential.identityToken,
                  let idToken = String(data: tokenData, encoding: .utf8),
                  let nonce = currentNonce else {
                appleError = isSpanish ? "Apple no devolvió una credencial válida." : "Apple did not return a valid credential."
                return
            }
            appleError = nil
            Task {
                if await service.signInWithApple(idToken: idToken, nonce: nonce) {
                    _ = await service.submit(score: score, displayName: displayName)
                }
            }
        case .failure(let error as ASAuthorizationError) where error.code == .canceled:
            break
        case .failure(let error):
            appleError = error.localizedDescription
        }
    }

    private static func sha256(_ value: String) -> String {
        SHA256.hash(data: Data(value.utf8)).map { String(format: "%02x", $0) }.joined()
    }

    private static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let characters = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remaining = length

        while remaining > 0 {
            var bytes = [UInt8](repeating: 0, count: 16)
            guard SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes) == errSecSuccess else {
                return UUID().uuidString.replacingOccurrences(of: "-", with: "")
            }
            for byte in bytes where remaining > 0 {
                if Int(byte) < characters.count {
                    result.append(characters[Int(byte)])
                    remaining -= 1
                }
            }
        }
        return result
    }
}
