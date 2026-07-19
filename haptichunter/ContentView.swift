import SwiftUI
import CoreHaptics
import AVFoundation
import Combine
import GoogleMobileAds

// --- GESTOR DE IDIOMA Y TEXTOS ---
enum AppLanguage: String {
    case en
    case es
}

class Localization {
    static func get(_ key: String, lang: AppLanguage) -> String {
        switch lang {
        case .en:
            switch key {
            // General
            case "splash_sub": return "FEEL THE UNSEEN."
            case "splash_main": return "HUNT THE SIGNAL."
            case "start_btn": return "START SYSTEM"
            case "mission_proto": return "MISSION PROTOCOL"
            case "sys_req_title": return "⚠️ SYSTEM REQUIREMENT"
            case "sys_req_desc": return "For the game to work, go to iPhone Settings > Sounds & Haptics > enable 'System Haptics'. Also check the silent switch."
            case "obj_title": return "1. OBJECTIVE"
            case "obj_desc": return "Find invisible targets using haptic feedback."
            case "ctrl_title": return "2. CONTROLS"
            case "ctrl_desc": return "• DRAG to scan.\n• LIFT to fire.\n• VIBRATION increases as you get closer."
            case "modes_title": return "3. OPERATING MODES"
            case "warn_title": return "4. WARNINGS"
            case "warn_desc": return "Time bar depletes constantly. Finding a target refills it."
            case "understand_btn": return "I UNDERSTAND"
            case "locked_out": return "LOCKED OUT"
            case "signal_lost": return "SIGNAL LOST"
            case "tactical_report": return "TACTICAL REPORT"
            case "score": return "SCORE"
            case "personal_best": return "PERSONAL BEST"
            case "average": return "AVERAGE"
            case "daily_challenge": return "DAILY CHALLENGE"
            case "attempts": return "ATTEMPTS"
            case "targets": return "TARGETS"
            case "wins": return "WINS"
            case "record": return "RECORD"
            case "re_init": return "RESTART"
            
            // Modos
            case "mode_visual_title": return "VISUAL MODE"
            case "mode_visual_desc": return "Radar colors active. Sparks visible.\nStandard Hitbox.\n5 Attempts."
            case "mode_blind_title": return "BLIND MODE"
            case "mode_blind_desc": return "No colors. No sparks. Pure audio/tactile.\nStandard Hitbox (Harder).\n5 Attempts."
            case "mode_precision_title": return "PRECISION MODE"
            case "mode_precision_desc": return "Visuals Active.\nLargest Hitbox (70px).\n⚠️ 1 ATTEMPT ONLY (Instant Death)."
            case "mode_random_title": return "RANDOM MODE"
            case "mode_random_desc": return "Every round is different.\nTest your adaptability.\nSeparate leaderboard."
            case "mode_daily_title": return "DAILY CHALLENGE"
            case "mode_daily_desc": return "One seed per day.\nSame map for everyone.\nCompete for the day's high score."
            
            // Premium View
            case "premium_title": return "SYSTEM UPGRADE"
            case "premium_desc": return "REMOVE ADS PERMANENTLY"
            case "feat_ads": return "NO INTERRUPTIONS"
            case "feat_restart": return "FASTER RESTART"
            case "feat_support": return "SUPPORT DEV"
            case "btn_upgrade": return "UPGRADE NOW"
            case "price_tag": return "1,99 € - ONE TIME"
            case "btn_nothanks": return "NO THANKS"
            case "thanks_title": return "SYSTEM UPGRADED"
            case "thanks_msg": return "Thank you for supporting xb.app. All ads are disabled permanently."
            case "ok_btn": return "CONTINUE"
            default: return key
            }
        case .es:
            switch key {
            // General
            case "splash_sub": return "SIENTE LO INVISIBLE."
            case "splash_main": return "CAZA LA SEÑAL."
            case "start_btn": return "INICIAR SISTEMA"
            case "mission_proto": return "PROTOCOLO MISIÓN"
            case "sys_req_title": return "⚠️ REQUISITO DEL SISTEMA"
            case "sys_req_desc": return "Para jugar, ve a Ajustes > Sonidos y Vibración > activa 'Vibración del sistema'. Revisa el botón de silencio lateral."
            case "obj_title": return "1. OBJETIVO"
            case "obj_desc": return "Encuentra objetivos invisibles usando el tacto."
            case "ctrl_title": return "2. CONTROLES"
            case "ctrl_desc": return "• ARRASTRA para escanear.\n• SUELTA para disparar.\n• La VIBRACIÓN aumenta al acercarte."
            case "modes_title": return "3. MODOS OPERATIVOS"
            case "warn_title": return "4. ADVERTENCIAS"
            case "warn_desc": return "El tiempo baja constantemente. Encontrar un objetivo lo rellena."
            case "understand_btn": return "ENTENDIDO"
            case "locked_out": return "BLOQUEADO"
            case "signal_lost": return "SEÑAL PERDIDA"
            case "tactical_report": return "REPORTE TÁCTICO"
            case "score": return "PUNTOS"
            case "personal_best": return "RÉCORD PERSONAL"
            case "average": return "MEDIA"
            case "daily_challenge": return "RETO DIARIO"
            case "attempts": return "INTENTOS"
            case "targets": return "DIANAS"
            case "wins": return "VICTORIAS"
            case "record": return "RÉCORD"
            case "re_init": return "REINICIAR"
            
            // Modos
            case "mode_visual_title": return "MODO VISUAL"
            case "mode_visual_desc": return "Radar activo. Chispas visibles.\nHitbox estándar.\n5 Intentos."
            case "mode_blind_title": return "MODO A CIEGAS"
            case "mode_blind_desc": return "Sin colores. Sin chispas. Solo audio/tacto.\nHitbox estándar (Difícil).\n5 Intentos."
            case "mode_precision_title": return "MODO PRECISIÓN"
            case "mode_precision_desc": return "Visuales activos.\nHitbox grande (70px).\n⚠️ SOLO 1 INTENTO (Muerte Súbita)."
            case "mode_random_title": return "MODO ALEATORIO"
            case "mode_random_desc": return "Cada ronda es diferente.\nPrueba tu adaptabilidad.\nRanking separado."
            case "mode_daily_title": return "RETO DIARIO"
            case "mode_daily_desc": return "Una semilla al día.\nMismo mapa para todos.\nCompite por el Top 1 mundial."
            
            // Premium View
            case "premium_title": return "MEJORA DEL SISTEMA"
            case "premium_desc": return "ELIMINA ANUNCIOS SIEMPRE"
            case "feat_ads": return "SIN INTERRUPCIONES"
            case "feat_restart": return "REINICIO RÁPIDO"
            case "feat_support": return "APOYA AL DEV"
            case "btn_upgrade": return "MEJORAR AHORA"
            case "price_tag": return "1,99 € - PAGO ÚNICO"
            case "btn_nothanks": return "NO, GRACIAS"
            case "thanks_title": return "SISTEMA MEJORADO"
            case "thanks_msg": return "Gracias por apoyar a xb.app. Los anuncios están desactivados para siempre."
            case "ok_btn": return "CONTINUAR"
            default: return key
            }
        }
    }
}

// --- GESTOR DE ANUNCIOS ---
@MainActor
class AdCoordinator: NSObject, FullScreenContentDelegate, ObservableObject {
    @Published var interstitial: InterstitialAd?
    @Published var showPromo: Bool = false
    
    @AppStorage("adsWatchedCount") var adsWatchedCount: Int = 0
    
    // ID de prueba de Google
    let adUnitID = "ca-app-pub-3940256099942544/4411468910"
    
    func loadAd(isPremium: Bool) {
        if isPremium { return }
        
        let request = Request()
        InterstitialAd.load(with: adUnitID, request: request) { [weak self] ad, error in
            guard let self = self else { return }
            if let error = error {
                print("Error loading ad: \(error.localizedDescription)")
                return
            }
            Task { @MainActor in
                self.interstitial = ad
                self.interstitial?.fullScreenContentDelegate = self
            }
        }
    }
    
    func showAd(isPremium: Bool) {
        if isPremium { return }
        
        if let ad = interstitial {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let root = windowScene.windows.first?.rootViewController {
                ad.present(from: root)
            }
        } else {
            loadAd(isPremium: isPremium)
        }
    }
    
    // Se llama cuando se cierra el anuncio
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        adsWatchedCount += 1
        
        // --- LOGICA DE PROMO: CADA 3 ANUNCIOS ---
        if adsWatchedCount % 3 == 0 {
            showPromo = true
        }
        
        // Cargamos el siguiente anuncio (si no es premium, que aquí no lo sabemos, así que cargamos por defecto)
        // El control real de no mostrarlo se hace en showAd()
        loadAd(isPremium: false)
    }
}

// --- ENUMERACIÓN DE MODOS ---
enum GameMode: String, CaseIterable {
    case visual
    case blind
    case precision
    case random
    case daily
    
    var iconName: String {
        switch self {
        case .visual: return "eye.fill"
        case .blind: return "eye.slash.fill"
        case .precision: return "target"
        case .random: return "dice.fill"
        case .daily: return "calendar.badge.clock"
        }
    }
    
    func title(lang: AppLanguage) -> String {
        switch self {
        case .visual: return Localization.get("mode_visual_title", lang: lang)
        case .blind: return Localization.get("mode_blind_title", lang: lang)
        case .precision: return Localization.get("mode_precision_title", lang: lang)
        case .random: return Localization.get("mode_random_title", lang: lang)
        case .daily: return Localization.get("mode_daily_title", lang: lang)
        }
    }
    
    func desc(lang: AppLanguage) -> String {
        switch self {
        case .visual: return Localization.get("mode_visual_desc", lang: lang)
        case .blind: return Localization.get("mode_blind_desc", lang: lang)
        case .precision: return Localization.get("mode_precision_desc", lang: lang)
        case .random: return Localization.get("mode_random_desc", lang: lang)
        case .daily: return Localization.get("mode_daily_desc", lang: lang)
        }
    }
}

// --- GESTOR DE HÁPTICA ---
class HapticEngineManager: ObservableObject {
    private var engine: CHHapticEngine?
    private var continuousPlayer: CHHapticAdvancedPatternPlayer?
    
    init() { prepareHaptics() }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
            engine?.stoppedHandler = { _ in try? self.engine?.start() }
        } catch { print("Error Haptics: \(error)") }
    }
    
    func startContinuousHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.6)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensity, sharpness], relativeTime: 0, duration: 600)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            continuousPlayer = try engine?.makeAdvancedPlayer(with: pattern)
            try continuousPlayer?.start(atTime: 0)
        } catch { print("Error start: \(error)") }
    }
    
    func updateHapticIntensity(distance: CGFloat) {
        guard let player = continuousPlayer else { return }
        let detectionRadius: CGFloat = 450.0
        let normalized = 1.0 - Float(min(distance, detectionRadius) / detectionRadius)
        let finalIntensity = pow(normalized, 1.1)
        let dynamicIntensity = CHHapticDynamicParameter(parameterID: .hapticIntensityControl, value: finalIntensity, relativeTime: 0)
        let dynamicSharpness = CHHapticDynamicParameter(parameterID: .hapticSharpnessControl, value: finalIntensity, relativeTime: 0)
        try? player.sendParameters([dynamicIntensity, dynamicSharpness], atTime: 0)
    }
    
    func stopContinuousHaptic() { try? continuousPlayer?.stop(atTime: 0) }
    
    func playSuccessHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    func playErrorHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    func playGameOverHaptic() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

// --- MODELOS ---
struct Spark: Identifiable {
    let id = UUID()
    var position: CGPoint
    var opacity: Double = 1.0
    var scale: CGFloat = 1.0
    var angle: Double
}

// --- VISTA 1: SPLASH SCREEN ---
struct SplashView: View {
    var onStart: () -> Void
    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .en
    
    @State private var isAnimating = false
    @State private var showButton = false
    @State private var gridOpacity = 0.0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            CircuitPattern()
                .stroke(
                    LinearGradient(
                        colors: [.cyan.opacity(0.1), .blue.opacity(0.3), .clear],
                        startPoint: .top, endPoint: .bottom
                    ),
                    lineWidth: 1
                )
                .ignoresSafeArea()
                .opacity(gridOpacity)
            
            ZStack {
                Circle().fill(Color.blue.opacity(0.1)).frame(width: 300).blur(radius: 60).offset(x: -100, y: -200)
                Circle().fill(Color.cyan.opacity(0.1)).frame(width: 300).blur(radius: 60).offset(x: 100, y: 200)
            }
            
            VStack(spacing: 40) {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .shadow(color: .cyan, radius: 20)
                    .shadow(color: .blue, radius: 40)
                    .opacity(isAnimating ? 1 : 0)
                    .scaleEffect(isAnimating ? 1 : 0.8)
                
                VStack(spacing: 12) {
                    Text(Localization.get("splash_sub", lang: appLanguage))
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(.white.opacity(0.8))
                        .tracking(4)
                    
                    Text(Localization.get("splash_main", lang: appLanguage))
                        .font(.system(size: 26, weight: .black, design: .monospaced))
                        .foregroundColor(.cyan)
                        .shadow(color: .cyan.opacity(0.6), radius: 10)
                        .tracking(1)
                }
                .opacity(isAnimating ? 1 : 0)
                
                if showButton {
                    Button(action: onStart) {
                        HStack {
                            Text(Localization.get("start_btn", lang: appLanguage))
                            Image(systemName: "chevron.right")
                        }
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundColor(.black)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 30)
                        .background(Color.cyan)
                        .cornerRadius(8)
                        .shadow(color: .cyan.opacity(0.6), radius: 20)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white.opacity(0.5), lineWidth: 1))
                    }
                    .transition(.opacity.combined(with: .scale(scale: 0.9)))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 1.5)) { gridOpacity = 0.5 }
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) { isAnimating = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation(.easeInOut(duration: 0.5)) { showButton = true }
            }
        }
    }
}

// --- COMPONENTE: PATRÓN DE CIRCUITO ---
struct CircuitPattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let spacing: CGFloat = 40
        for x in stride(from: 0, to: w, by: spacing) {
            path.move(to: CGPoint(x: x, y: 0)); path.addLine(to: CGPoint(x: x, y: h))
        }
        for y in stride(from: 0, to: h, by: spacing) {
            path.move(to: CGPoint(x: 0, y: y)); path.addLine(to: CGPoint(x: w, y: y))
        }
        path.move(to: CGPoint(x: 0, y: 0)); path.addLine(to: CGPoint(x: w, y: h))
        path.move(to: CGPoint(x: w, y: 0)); path.addLine(to: CGPoint(x: 0, y: h))
        return path
    }
}

// --- VISTA 2: TUTORIAL ---
struct TutorialView: View {
    var onDismiss: () -> Void
    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .en
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.95).ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    Text(Localization.get("mission_proto", lang: appLanguage))
                        .font(.system(size: 22, weight: .black, design: .monospaced))
                        .foregroundStyle(.cyan)
                        .shadow(color: .cyan.opacity(0.6), radius: 8)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    Spacer()
                    
                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        withAnimation(.easeInOut(duration: 0.2)) {
                            appLanguage = (appLanguage == .en) ? .es : .en
                        }
                    }) {
                        Text(appLanguage == .en ? "[ EN ]" : "[ ES ]")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundColor(.cyan)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(Color.black.opacity(0.8))
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.cyan.opacity(0.7), lineWidth: 1))
                            .shadow(color: .cyan.opacity(0.4), radius: 4)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 50)
                .padding(.bottom, 20)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        instructionBlock(title: Localization.get("sys_req_title", lang: appLanguage),
                                         text: Localization.get("sys_req_desc", lang: appLanguage))
                            .padding(.bottom, 10)
                        
                        instructionBlock(title: Localization.get("obj_title", lang: appLanguage),
                                         text: Localization.get("obj_desc", lang: appLanguage))
                        
                        instructionBlock(title: Localization.get("ctrl_title", lang: appLanguage),
                                         text: Localization.get("ctrl_desc", lang: appLanguage))
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(Localization.get("modes_title", lang: appLanguage))
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundStyle(.white)
                            
                            TabView {
                                modeCard(icon: GameMode.visual.iconName,
                                         title: GameMode.visual.title(lang: appLanguage),
                                         desc: GameMode.visual.desc(lang: appLanguage))
                                modeCard(icon: GameMode.blind.iconName,
                                         title: GameMode.blind.title(lang: appLanguage),
                                         desc: GameMode.blind.desc(lang: appLanguage))
                                modeCard(icon: GameMode.precision.iconName,
                                         title: GameMode.precision.title(lang: appLanguage),
                                         desc: GameMode.precision.desc(lang: appLanguage))
                                modeCard(icon: GameMode.random.iconName,
                                         title: GameMode.random.title(lang: appLanguage),
                                         desc: GameMode.random.desc(lang: appLanguage))
                                modeCard(icon: GameMode.daily.iconName,
                                         title: GameMode.daily.title(lang: appLanguage),
                                         desc: GameMode.daily.desc(lang: appLanguage))
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            .frame(height: 180)
                        }
                        
                        instructionBlock(title: Localization.get("warn_title", lang: appLanguage),
                                         text: Localization.get("warn_desc", lang: appLanguage))
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.horizontal, 30)
                }
                
                Button(action: onDismiss) {
                    Text(Localization.get("understand_btn", lang: appLanguage))
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cyan)
                        .cornerRadius(12)
                        .shadow(color: .cyan.opacity(0.5), radius: 10)
                }
                .padding(30)
                .padding(.bottom, 20)
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("XB.app")
                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                        .foregroundColor(.gray.opacity(0.3))
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                }
            }
        }
        .zIndex(100)
    }
    
    func instructionBlock(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).font(.system(size: 16, weight: .bold, design: .monospaced)).foregroundStyle(.white)
            Text(text).font(.system(size: 14, design: .monospaced)).foregroundStyle(.gray).fixedSize(horizontal: false, vertical: true)
        }
    }
    
    func modeCard(icon: String, title: String, desc: String) -> some View {
        VStack {
            Image(systemName: icon).font(.system(size: 30)).foregroundStyle(.cyan).padding(.bottom, 5)
            Text(title).font(.system(size: 16, weight: .bold, design: .monospaced)).foregroundStyle(.white)
            Text(desc).font(.system(size: 12, design: .monospaced)).foregroundStyle(.gray).multilineTextAlignment(.center).padding(.horizontal)
            Spacer()
        }
        .padding(.top, 20).padding(.bottom, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.05))
        .cornerRadius(12).padding(.horizontal, 5)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.1), lineWidth: 1))
    }
}

// --- COMPONENTE: MAPA TÁCTICO ---
struct TacticalMap: View {
    let touchPath: [CGPoint]
    let targets: [CGPoint]
    let screenSize: CGSize
    
    var body: some View {
        GeometryReader { cardGeo in
            ZStack {
                Color.black
                // Grid
                Path { path in
                    let step = cardGeo.size.width / 10
                    for x in stride(from: 0, to: cardGeo.size.width, by: step) { path.move(to: CGPoint(x: x, y: 0)); path.addLine(to: CGPoint(x: x, y: cardGeo.size.height)) }
                }.stroke(Color.cyan.opacity(0.15), lineWidth: 1)
                Path { path in
                    let step = cardGeo.size.height / 10
                    for y in stride(from: 0, to: cardGeo.size.height, by: step) { path.move(to: CGPoint(x: 0, y: y)); path.addLine(to: CGPoint(x: cardGeo.size.width, y: y)) }
                }.stroke(Color.cyan.opacity(0.15), lineWidth: 1)
                
                // Path
                if !touchPath.isEmpty {
                    Path { path in
                        path.move(to: mapPoint(touchPath[0], from: screenSize, to: cardGeo.size))
                        for point in touchPath.dropFirst() { path.addLine(to: mapPoint(point, from: screenSize, to: cardGeo.size)) }
                    }.stroke(LinearGradient(gradient: Gradient(colors: [.cyan.opacity(0), .cyan, .white]), startPoint: .leading, endPoint: .trailing), style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)).shadow(color: .cyan, radius: 5)
                }
                
                // Puntos de calor
                ForEach(Array(touchPath.enumerated()), id: \.offset) { index, point in
                    if index % 5 == 0 {
                        Circle().fill(Color.cyan).frame(width: 4, height: 4).position(mapPoint(point, from: screenSize, to: cardGeo.size)).opacity(Double(index)/Double(touchPath.count)*0.8).blur(radius: 1)
                    }
                }
                
                // Objetivos
                ForEach(0..<targets.count, id: \.self) { i in
                    let mapped = mapPoint(targets[i], from: screenSize, to: cardGeo.size)
                    ZStack {
                        Circle().stroke(Color.red.opacity(0.6), lineWidth: 1).frame(width: 30, height: 30)
                        Circle().stroke(Color.red, lineWidth: 2).frame(width: 14, height: 14)
                        Path { p in p.move(to: CGPoint(x: 15, y: 0)); p.addLine(to: CGPoint(x: 15, y: 30)); p.move(to: CGPoint(x: 0, y: 15)); p.addLine(to: CGPoint(x: 30, y: 15)) }.stroke(Color.red, lineWidth: 1).frame(width: 30, height: 30)
                    }.position(mapped)
                }
            }
            .drawingGroup()
        }
        .frame(height: 250).background(Color.black.opacity(0.8)).clipped().cornerRadius(12).overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
    }
    
    func mapPoint(_ point: CGPoint, from sourceSize: CGSize, to destSize: CGSize) -> CGPoint {
        guard sourceSize.width > 0, sourceSize.height > 0 else { return .zero }
        let xRatio = destSize.width / sourceSize.width
        let yRatio = destSize.height / sourceSize.height
        return CGPoint(x: point.x * xRatio, y: point.y * yRatio)
    }
}

// --- VISTA 3: CONTENT VIEW ---
struct ContentView: View {
    @StateObject private var hapticManager = HapticEngineManager()
    @StateObject private var ads = AdCoordinator()
    @StateObject private var leaderboard = LeaderboardService()
    
    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .en
    @StateObject private var soundManager = SoundManager()
    // --- PERSISTENCIA PRINCIPAL ---
    // Esta es la ÚNICA verdad sobre si es premium o no.
    @AppStorage("isPremiumUser") var isPremiumUser: Bool = false
    
    @State private var showThanksAlert: Bool = false
    @State private var showLeaderboard: Bool = false
    // --- ESTADÍSTICAS ---
    @AppStorage("score_visual") private var visualBest: Int = 0
    @AppStorage("score_blind") private var blindBest: Int = 0
    @AppStorage("score_precision") private var precisionBest: Int = 0
    @AppStorage("score_random") private var randomBest: Int = 0
    @AppStorage("score_daily") private var dailyBest: Int = 0
    @AppStorage("last_daily_date") private var lastDailyDate: String = ""
    
    @AppStorage("daily_wins_count") private var dailyWins: Int = 0
    @AppStorage("last_daily_win_date") private var lastDailyWinDate: String = ""
    
    @AppStorage("total_visual") private var visualTotal: Int = 0
    @AppStorage("games_visual") private var visualGames: Int = 0
    @AppStorage("total_blind") private var blindTotal: Int = 0
    @AppStorage("games_blind") private var blindGames: Int = 0
    @AppStorage("total_precision") private var precisionTotal: Int = 0
    @AppStorage("games_precision") private var precisionGames: Int = 0
    @AppStorage("total_random") private var randomTotal: Int = 0
    @AppStorage("games_random") private var randomGames: Int = 0
    
    // --- CONTADOR DE PARTIDAS PARA ANUNCIOS ---
    @AppStorage("gamesPlayedCount") private var gamesPlayedCount: Int = 0
    
    @AppStorage("hasSeenTutorial_v4") private var hasSeenTutorial: Bool = false
    @State private var showTutorial: Bool = false
    
    // UI STATES
    @State private var selectedMode: GameMode = .visual
    @State private var activeRoundMode: GameMode = .visual
    @State private var showModeDropdown: Bool = false
    @State private var showSplashScreen: Bool = true
    
    // HELPERS
    var currentBestScore: Int {
        switch selectedMode {
        case .visual: return visualBest
        case .blind: return blindBest
        case .precision: return precisionBest
        case .random: return randomBest
        case .daily: return dailyBest
        }
    }
    
    var currentAverageDisplay: String {
        let total: Int, games: Int
        switch selectedMode {
        case .visual: (total, games) = (visualTotal, visualGames)
        case .blind: (total, games) = (blindTotal, blindGames)
        case .precision: (total, games) = (precisionTotal, precisionGames)
        case .random: (total, games) = (randomTotal, randomGames)
        case .daily: return "N/A"
        }
        if games == 0 { return "0.0" }
        return String(format: "%.1f", Double(total) / Double(games))
    }
    
    var currentHitThreshold: CGFloat {
        switch activeRoundMode {
        case .visual: return 55.0
        case .blind: return 55.0
        case .precision: return 70.0
        default: return 55.0
        }
    }
    
    var currentMaxAttempts: Int {
        switch activeRoundMode {
        case .precision: return 1
        default: return 5
        }
    }
    
    func getOtherModes() -> [GameMode] {
        GameMode.allCases.filter { $0 != selectedMode }
    }
    
    // Juego
    @State private var targets: [CGPoint] = []
    @State private var currentTouchPosition: CGPoint? = nil
    @State private var score: Int = 0
    @State private var screenSize: CGSize = .zero
    @State private var isGameOver: Bool = false
    @State private var attemptsUsed: Int = 0
    @State private var isGameStarted: Bool = false
    @State private var touchPath: [CGPoint] = []
    
    // Visuals
    @State private var showExplosion: Bool = false
    @State private var showHitFlash: Bool = false
    @State private var rippleScale: CGFloat = 1.0
    @State private var rippleOpacity: Double = 1.0
    @State private var proximityColor: Color = .cyan
    @State private var sparks: [Spark] = []
    @State private var shakeOffset: CGFloat = 0.0
    @State private var glitchOffset: CGFloat = 0.0
    
    // Tiempo
    @State private var timeLeft: CGFloat = 1.0
    @State private var timerActive: Bool = false
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.ignoresSafeArea()
                
                if !isGameOver && timeLeft < 0.3 && activeRoundMode != .blind {
                    Color.red.opacity(Double.random(in: 0.05...0.15)).ignoresSafeArea().blendMode(.screen)
                }
                
                if showHitFlash { Color.white.ignoresSafeArea().zIndex(50) }
                
                if showTutorial {
                    TutorialView {
                        hasSeenTutorial = true
                        showTutorial = false
                        // --- CORRECCIÓN CLAVE ---
                        // Solo inicia el juego automáticamente si NO estamos muertos.
                        if !isGameOver {
                            resetGame()
                        }
                    }
                    .transition(.opacity)
                }
                
                if isGameOver {
                    ZStack {
                        Color.black.opacity(0.9).ignoresSafeArea()
                        
                        // --- CAPA SUPERIOR: BOTONES DE ESQUINA ---
                        VStack {
                            HStack {
                                // BOTÓN BASURA (IZQUIERDA) - RESET TOTAL
                                Button(action: {
                                    if let bundleID = Bundle.main.bundleIdentifier {
                                        UserDefaults.standard.removePersistentDomain(forName: bundleID)
                                    }
                                    isPremiumUser = false
                                    gamesPlayedCount = 0
                                    isGameOver = false
                                    score = 0
                                    timeLeft = 1.0
                                    hasSeenTutorial = false
                                    showSplashScreen = true
                                    let generator = UINotificationFeedbackGenerator()
                                    generator.notificationOccurred(.success)
                                }) {
                                    Image(systemName: "trash.fill")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.gray.opacity(0.5))
                                        .padding(10)
                                        .background(Color.white.opacity(0.05))
                                        .clipShape(Circle())
                                }

                                Spacer()

                                // --- CORONA PERMANENTE ---
                                Button(action: {
                                    if isPremiumUser {
                                        showThanksAlert = true
                                    } else {
                                        withAnimation { ads.showPromo = true }
                                    }
                                }) {
                                    Image(systemName: isPremiumUser ? "checkmark.seal.fill" : "crown.fill")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(isPremiumUser ? .green : .yellow)
                                        .padding(10)
                                        .background(isPremiumUser ? Color.green.opacity(0.1) : Color.yellow.opacity(0.1))
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(isPremiumUser ? Color.green.opacity(0.5) : Color.yellow.opacity(0.5), lineWidth: 1))
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 50)
                            
                            Spacer()
                        }
                        .zIndex(65)
                        
                        // --- CONTENIDO CENTRAL GAME OVER ---
                        VStack(spacing: 20) {
                            Text(attemptsUsed > currentMaxAttempts ? Localization.get("locked_out", lang: appLanguage) : Localization.get("signal_lost", lang: appLanguage))
                                .font(.system(size: 30, weight: .black, design: .monospaced))
                                .foregroundStyle(.red)
                                .shadow(color: .red, radius: 10)
                            
                            // REPORT CARD
                            VStack(spacing: 0) {
                                HStack {
                                    Text(Localization.get("tactical_report", lang: appLanguage))
                                        .font(.system(size: 10, design: .monospaced))
                                        .foregroundStyle(.gray)
                                    Spacer()
                                    Image(systemName: selectedMode.iconName)
                                        .font(.system(size: 10))
                                        .foregroundStyle(.cyan)
                                    Text(selectedMode.title(lang: appLanguage).uppercased())
                                        .font(.system(size: 10, weight: .bold, design: .monospaced))
                                        .foregroundStyle(.cyan)
                                }
                                .padding(.horizontal, 40)
                                .padding(.vertical, 10)
                                
                                TacticalMap(touchPath: touchPath, targets: targets, screenSize: screenSize)
                                    .padding(.horizontal, 40)
                            }
                            
                            VStack(spacing: 5) {
                                Text(Localization.get("score", lang: appLanguage)).font(.system(size: 12, design: .monospaced)).foregroundStyle(.gray)
                                Text("\(score)").font(.system(size: 40, weight: .bold, design: .monospaced)).foregroundStyle(.white)
                            }
                            
                            VStack(spacing: 4) {
                                Text("\(Localization.get("personal_best", lang: appLanguage)): \(currentBestScore)")
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundStyle(.white.opacity(0.5))
                                
                                if selectedMode != .daily {
                                    Text("\(Localization.get("average", lang: appLanguage)): \(currentAverageDisplay)")
                                        .font(.system(size: 12, design: .monospaced))
                                        .foregroundStyle(.cyan.opacity(0.7))
                                } else {
                                    Text(Localization.get("daily_challenge", lang: appLanguage))
                                        .font(.system(size: 12, design: .monospaced))
                                        .foregroundStyle(.cyan.opacity(0.7))
                                }
                            }
                            
                            HStack(spacing: 15) {
                                // BOTÓN TUTORIAL
                                Button(action: { showTutorial = true }) {
                                    Image(systemName: "questionmark").font(.system(size: 20, weight: .bold)).foregroundStyle(.cyan).frame(width: 50, height: 50)
                                        .background(Color.cyan.opacity(0.1)).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.cyan, lineWidth: 1)).cornerRadius(8)
                                }
                                
                                // BOTÓN LEADERBOARD (SOLO DAILY)
                                if selectedMode == .daily {
                                    Button(action: { showLeaderboard = true }) {
                                        Image(systemName: "list.number").font(.system(size: 20, weight: .bold)).foregroundStyle(.yellow).frame(width: 50, height: 50)
                                            .background(Color.yellow.opacity(0.1)).overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.yellow, lineWidth: 1)).cornerRadius(8)
                                    }
                                }
                                
                                // BOTÓN REINICIAR PARTIDA
                                Button(action: resetGame) {
                                    Text(Localization.get("re_init", lang: appLanguage)).font(.system(size: 16, weight: .bold, design: .monospaced)).foregroundStyle(.black)
                                        .padding(.vertical, 15).padding(.horizontal, 20).background(Color.cyan).cornerRadius(8)
                                }
                            }
                            .padding(.top, 10)
                        }
                        
                        // Footer XB.app
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("XB.app").font(.system(size: 10, weight: .bold, design: .monospaced)).foregroundColor(.gray.opacity(0.4)).padding()
                            }
                        }
                        
                    }
                    .zIndex(60)
                    .transition(.opacity)
                } else {
                    // JUEGO ACTIVO
                    ZStack {
                        Color.clear
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        if showModeDropdown { withAnimation { showModeDropdown = false }; return }
                                        if showTutorial { return }
                                        if !isGameStarted { withAnimation(.easeOut(duration: 0.2)) { isGameStarted = true } }
                                        if !timerActive { timerActive = true }
                                        handleTouchMove(location: value.location)
                                    }
                                    .onEnded { value in
                                        if !showTutorial && !showModeDropdown { handleTouchLift(location: value.location) }
                                    }
                            )
                        
                        if let touchPos = currentTouchPosition {
                            ZStack {
                                if activeRoundMode != .blind {
                                    ForEach(sparks) { spark in
                                        Circle().fill(Color.white).frame(width: 3, height: 3)
                                            .offset(x: cos(spark.angle) * 20 * spark.scale, y: sin(spark.angle) * 20 * spark.scale)
                                            .opacity(spark.opacity).position(spark.position)
                                    }
                                }
                                Circle().stroke(activeRoundMode == .blind ? Color.white.opacity(0.3) : proximityColor.opacity(0.6), lineWidth: 3)
                                    .frame(width: 60 * rippleScale, height: 60 * rippleScale).opacity(rippleOpacity)
                                Circle().fill(activeRoundMode == .blind ? Color.white.opacity(0.5) : proximityColor)
                                    .frame(width: 12, height: 12).shadow(color: activeRoundMode == .blind ? .white.opacity(0.2) : proximityColor, radius: 15)
                            }
                            .position(touchPos).allowsHitTesting(false)
                        }
                        
                        if showExplosion {
                            Circle().stroke(Color.white, lineWidth: 4).frame(width: 300, height: 300)
                                .position(currentTouchPosition ?? CGPoint(x: geo.size.width/2, y: geo.size.height/2))
                                .opacity(0).transition(.scale(scale: 0.1).combined(with: .opacity)).allowsHitTesting(false)
                        }
                        
                        // UI SUPERIOR
                        VStack(spacing: 0) {
                            ZStack(alignment: .leading) {
                                Rectangle().fill(Color.gray.opacity(0.3)).frame(height: 8)
                                Rectangle().fill(timeLeft < 0.3 ? Color.red : Color.cyan)
                                    .frame(width: geo.size.width * max(0, timeLeft), height: 8)
                                    .shadow(color: timeLeft < 0.3 ? .red : .cyan, radius: (timeLeft < 0.3 && Int(Date().timeIntervalSince1970 * 10) % 2 == 0) ? 15 : 5)
                            }
                            
                            ZStack(alignment: .top) {
                                if !isGameStarted {
                                    HStack {
                                        Button(action: {
                                            let generator = UIImpactFeedbackGenerator(style: .medium)
                                            generator.impactOccurred()
                                            withAnimation(.spring()) { showModeDropdown.toggle() }
                                        }) {
                                            Image(systemName: "slider.horizontal.3").font(.system(size: 24)).foregroundColor(.cyan).padding(12)
                                                .background(Circle().fill(Color.white.opacity(0.1))).overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                                        }
                                        .overlay(Group { if showModeDropdown { modeDropdownMenu().offset(y: 60) } }, alignment: .topLeading)
                                        .zIndex(20)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, 20).padding(.top, 20)
                                }
                                
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 4) {
                                        HStack(spacing: 15) {
                                            Text("\(Localization.get("attempts", lang: appLanguage)): \(attemptsUsed)/\(currentMaxAttempts)")
                                                .font(.system(size: 12, design: .monospaced))
                                                .foregroundStyle(attemptsUsed >= currentMaxAttempts - 1 ? .red : .gray)
                                            Text("\(Localization.get("targets", lang: appLanguage)): \(score)").font(.system(size: 14, design: .monospaced)).foregroundStyle(.gray)
                                        }
                                        
                                        if selectedMode == .daily {
                                            HStack(spacing: 5) {
                                                Image(systemName: "crown.fill")
                                                    .font(.system(size: 10))
                                                    .foregroundStyle(.gray.opacity(0.5))
                                                Text("\(Localization.get("wins", lang: appLanguage)): \(dailyWins)")
                                                    .font(.system(size: 10, design: .monospaced))
                                                    .foregroundStyle(.gray.opacity(0.5))
                                            }
                                        }
                                        
                                        HStack(spacing: 5) {
                                            Image(systemName: selectedMode.iconName).font(.system(size: 10)).foregroundStyle(.gray.opacity(0.5))
                                            Text("\(Localization.get("record", lang: appLanguage)): \(currentBestScore)").font(.system(size: 10, design: .monospaced)).foregroundStyle(.gray.opacity(0.5))
                                        }
                                    }
                                }
                                .padding(.trailing, 20).padding(.top, 10)
                            }
                            Spacer()
                        }
                    }
                }
                
                if showSplashScreen {
                    SplashView(onStart: {
                        withAnimation(.easeOut(duration: 0.5)) { showSplashScreen = false }
                        if !hasSeenTutorial { showTutorial = true } else { startGame() }
                    })
                    .zIndex(200).transition(.opacity)
                }
            }
            .offset(x: shakeOffset + glitchOffset, y: glitchOffset)
            .onAppear {
            
                soundManager.prepareSounds()
                self.screenSize = geo.size
                checkDailyReset()
                ads.loadAd(isPremium: isPremiumUser)
            }
            .onReceive(timer) { _ in gameLoop() }
            .alert(isPresented: $showThanksAlert) {
                Alert(
                    title: Text(Localization.get("thanks_title", lang: appLanguage)),
                    message: Text(Localization.get("thanks_msg", lang: appLanguage)),
                    dismissButton: .default(Text(Localization.get("ok_btn", lang: appLanguage)))
                )
            }
        }
        .statusBar(hidden: true)
        .fullScreenCover(isPresented: $ads.showPromo) {
            PremiumView(
                ads: ads,
                onUpgrade: {
                    isPremiumUser = true
                    ads.interstitial = nil
                    showThanksAlert = true
                }
            )
        }
        .sheet(isPresented: $showLeaderboard) {
            LeaderboardView(
                service: leaderboard,
                score: score,
                language: appLanguage
            )
        }
    }
    
    @ViewBuilder
    func modeDropdownMenu() -> some View {
        VStack(spacing: 8) {
            ForEach(getOtherModes(), id: \.self) { mode in
                smallModeCard(mode: mode)
            }
        }
        .padding(10).background(Color.black.opacity(0.9)).cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.cyan.opacity(0.5), lineWidth: 1))
        .shadow(color: .cyan.opacity(0.2), radius: 10)
    }
    
    @ViewBuilder
    func smallModeCard(mode: GameMode) -> some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .medium); generator.impactOccurred()
            withAnimation {
                selectedMode = mode
                if mode != .random && mode != .daily { activeRoundMode = mode }
                showModeDropdown = false
                resetGame()
            }
        }) {
            HStack {
                Spacer()
                Image(systemName: mode.iconName).font(.system(size: 20)).foregroundStyle(.cyan)
                Spacer()
            }
            .frame(width: 44, height: 44).background(Color.white.opacity(0.05)).cornerRadius(8)
        }
    }
    
    // --- LÓGICA DE JUEGO ---
    
    func getDeterministicCoordinate(seed: Int) -> CGFloat {
        var x = UInt64(bitPattern: Int64(seed))
        x = (~x) &+ (x << 21)
        x = x ^ (x >> 24)
        x = (x &+ (x << 3)) &+ (x << 8)
        x = x ^ (x >> 14)
        x = (x &+ (x << 2)) &+ (x << 4)
        x = x ^ (x >> 28)
        x = x &+ (x << 31)
        return CGFloat(Double(x % 100000) / 100000.0)
    }
    
    func checkDailyReset() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.string(from: Date())
        if lastDailyDate != today {
            dailyBest = 0
            lastDailyDate = today
        }
    }
    
    func mapPoint(_ point: CGPoint, from sourceSize: CGSize, to destSize: CGSize) -> CGPoint {
        guard sourceSize.width > 0, sourceSize.height > 0 else { return .zero }
        let xRatio = destSize.width / sourceSize.width
        let yRatio = destSize.height / sourceSize.height
        return CGPoint(x: point.x * xRatio, y: point.y * yRatio)
    }
    
    func minDistanceToAnyTarget(_ point: CGPoint) -> CGFloat {
        var minD: CGFloat = 10000.0
        for t in targets {
            let d = distanceBetween(point1: point, point2: t)
            if d < minD { minD = d }
        }
        return minD
    }
    
    func gameLoop() {
        if showTutorial || showModeDropdown || showSplashScreen { return }
        
        if timerActive && !isGameOver {
            let decay = 0.002 + (Double(score) * 0.00015)
            timeLeft -= decay
            if timeLeft <= 0 { gameOver() }
            if timeLeft < 0.3 && activeRoundMode != .blind { glitchOffset = CGFloat.random(in: -3...3) } else { glitchOffset = 0 }
        }
        if currentTouchPosition != nil {
            withAnimation(.linear(duration: 0.8).repeatForever(autoreverses: false)) { rippleScale = 2.5; rippleOpacity = 0.0 }
        } else { rippleScale = 1.0; rippleOpacity = 1.0 }
        updateSparks()
    }
    
    func startGame() {
        if showTutorial || showSplashScreen { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            randomizeTargets()
            hapticManager.prepareHaptics()
            timeLeft = 1.0; score = 0; attemptsUsed = 0
            isGameOver = false; timerActive = false; isGameStarted = false; touchPath = []
        }
    }
    
    func resetGame() {
        score = 0; timeLeft = 1.0; attemptsUsed = 0
        isGameOver = false; timerActive = false; isGameStarted = false; touchPath = []
        hapticManager.prepareHaptics()
        randomizeTargets()
        soundManager.stopAll()
    }
    
    func gameOver() {
        switch selectedMode {
        case .visual: visualTotal += score; visualGames += 1
        case .blind: blindTotal += score; blindGames += 1
        case .precision: precisionTotal += score; precisionGames += 1
        case .random: randomTotal += score; randomGames += 1
        case .daily:
            if leaderboard.isAuthenticated {
                let displayName = UserDefaults.standard.string(forKey: "leaderboardDisplayName") ?? "Hunter"
                Task { _ = await leaderboard.submit(score: score, displayName: displayName) }
            }
        }
        
        isGameOver = true
        hapticManager.stopContinuousHaptic()
        hapticManager.playGameOverHaptic()
        soundManager.stopAll()
        
        if !isPremiumUser { // Solo cuenta y muestra si NO es premium
            gamesPlayedCount += 1
            if gamesPlayedCount % 4 == 0 {
                ads.showAd(isPremium: false)
            }
        }
    }
    
    func randomizeTargets() {
        if selectedMode == .random {
            let modes: [GameMode] = [.visual, .blind, .precision]
            activeRoundMode = modes.randomElement() ?? .visual
        } else if selectedMode == .daily {
            activeRoundMode = .visual
        } else {
            activeRoundMode = selectedMode
        }
        
        let margin: CGFloat = 60
        guard screenSize.width > 0 else { return }
        targets = []
        
        if selectedMode == .daily {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let todaySeed = Int(formatter.string(from: Date())) ?? 0
            
            let seedX = todaySeed + (score * 100) + 1
            let seedY = todaySeed + (score * 100) + 2
            
            let x = margin + (getDeterministicCoordinate(seed: seedX) * (screenSize.width - margin * 2))
            let y = margin + (getDeterministicCoordinate(seed: seedY) * (screenSize.height - margin * 2))
            targets.append(CGPoint(x: x, y: y))
            
        } else {
            let x1 = CGFloat.random(in: margin...(screenSize.width - margin))
            let y1 = CGFloat.random(in: margin...(screenSize.height - margin))
            targets.append(CGPoint(x: x1, y: y1))
            
            if score > 5 && Int.random(in: 0...10) > 6 {
                var x2 = CGFloat.random(in: margin...(screenSize.width - margin))
                var y2 = CGFloat.random(in: margin...(screenSize.height - margin))
                while distanceBetween(point1: CGPoint(x: x1, y: y1), point2: CGPoint(x: x2, y: y2)) < 150 {
                    x2 = CGFloat.random(in: margin...(screenSize.width - margin))
                    y2 = CGFloat.random(in: margin...(screenSize.height - margin))
                }
                targets.append(CGPoint(x: x2, y: y2))
            }
        }
    }
    
    func handleTouchMove(location: CGPoint) {
        if currentTouchPosition == nil { soundManager.startCharging() }
        if currentTouchPosition == nil { hapticManager.startContinuousHaptic() }
        currentTouchPosition = location
        touchPath.append(location)
        if touchPath.count > 2000 { touchPath.removeFirst() }
        
        let dist = minDistanceToAnyTarget(location)
        
        if activeRoundMode == .blind { proximityColor = .white }
        else {
            if dist < 80 {
                proximityColor = .red
                if Int.random(in: 0...10) > 6 { createSpark(at: location) }
            } else if dist < 250 { proximityColor = .yellow } else { proximityColor = .cyan }
        }
        hapticManager.updateHapticIntensity(distance: dist)
        soundManager.updateProximity(distance: dist)
    }
    
    func handleTouchLift(location: CGPoint) {
        soundManager.chargePlayer?.stop()
        hapticManager.stopContinuousHaptic()
        currentTouchPosition = nil
        proximityColor = .cyan
        
        var hit = false
        for target in targets {
            if distanceBetween(point1: location, point2: target) < currentHitThreshold { hit = true; break }
        }
        if hit { targetHit() } else { missedAttempt(); soundManager.playFail()}
    }
    
    func missedAttempt() {
        attemptsUsed += 1
        hapticManager.playErrorHaptic()
        if activeRoundMode == .precision { gameOver() }
        else { if attemptsUsed > currentMaxAttempts { gameOver() } else { withAnimation { timeLeft -= 0.05 } } }
    }
    
    func targetHit() {
        score += 1
        switch selectedMode {
        case .visual: if score > visualBest { visualBest = score }
        case .blind: if score > blindBest { blindBest = score }
        case .precision: if score > precisionBest { precisionBest = score }
        case .random: if score > randomBest { randomBest = score }
        case .daily:
            if score > dailyBest { dailyBest = score }
        
        }
        timeLeft = 1.0; attemptsUsed = 0; touchPath = []
        hapticManager.playSuccessHaptic()
        soundManager.playSuccess()
        triggerShake()
        
        withAnimation(.easeIn(duration: 0.05)) { showHitFlash = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { withAnimation(.easeOut(duration: 0.2)) { self.showHitFlash = false } }
        withAnimation(.easeOut(duration: 0.3)) { showExplosion = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { showExplosion = false }
        randomizeTargets()
    }
    
    func triggerShake() {
        let impacts = 5
        for i in 0..<impacts { DispatchQueue.main.asyncAfter(deadline: .now() + (Double(i) * 0.02)) { self.shakeOffset = CGFloat.random(in: -10...10) } }
        DispatchQueue.main.asyncAfter(deadline: .now() + (Double(impacts) * 0.02)) { self.shakeOffset = 0 }
    }
    
    func createSpark(at position: CGPoint) {
        let spark = Spark(position: position, angle: Double.random(in: 0...2 * .pi))
        sparks.append(spark)
    }
    
    func updateSparks() {
        for i in sparks.indices {
            sparks[i].scale -= 0.05; sparks[i].opacity -= 0.1
            let speed: CGFloat = 3.0
            sparks[i].position.x += cos(sparks[i].angle) * speed
            sparks[i].position.y += sin(sparks[i].angle) * speed
        }
        sparks.removeAll{ $0.opacity <= 0 }
    }
    
    func distanceBetween(point1: CGPoint, point2: CGPoint) -> CGFloat {
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
}


struct PremiumView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var ads: AdCoordinator
    var onUpgrade: () -> Void
    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .en
    // Usamos AppStorage DIRECTAMENTE para que sea imposible que falle el estado

    
    var body: some View {
        ZStack {
            // Fondo oscuro desenfocado
            Color.black.opacity(0.9).ignoresSafeArea()
            CircuitPattern().stroke(Color.yellow.opacity(0.1), lineWidth: 1).ignoresSafeArea()
            
            VStack(spacing: 30) {
                HStack {
                    Spacer()
                    Button {
                        ads.showPromo = false
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.gray)
                    }
                    .accessibilityLabel(appLanguage == .es ? "Cerrar" : "Close")
                }

                Image(systemName: "lock.open.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.yellow)
                    .shadow(color: .yellow, radius: 20)
                    .padding(.top, 40)
                
                VStack(spacing: 10) {
                    Text(Localization.get("premium_title", lang: appLanguage))
                        .font(.system(size: 24, weight: .black, design: .monospaced))
                        .foregroundStyle(.white)
                    Text(Localization.get("premium_desc", lang: appLanguage))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(.gray)
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    featureRow(icon: "speaker.slash.fill", text: Localization.get("feat_ads", lang: appLanguage))
                    featureRow(icon: "bolt.fill", text: Localization.get("feat_restart", lang: appLanguage))
                    featureRow(icon: "heart.fill", text: Localization.get("feat_support", lang: appLanguage))
                }
                .padding(.vertical, 20)
                
                Spacer()
                
                // BOTÓN DE PAGO SIMULADO
                Button(action: {
                    onUpgrade()
                    ads.showPromo = false
                    dismiss()
                })  {
                    VStack(spacing: 5) {
                        Text(Localization.get("btn_upgrade", lang: appLanguage))
                            .font(.system(size: 20, weight: .black, design: .monospaced))
                        Text(Localization.get("price_tag", lang: appLanguage))
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .shadow(color: .yellow.opacity(0.5), radius: 15)
                }
                .padding(.horizontal, 40)
                
                // BOTÓN NO THANKS
                Button(action: {
                    ads.showPromo = false
                    dismiss()
                }) {
                    Text(Localization.get("btn_nothanks", lang: appLanguage))
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundStyle(.gray)
                        .padding(.bottom, 20)
                }
            }
            .padding(20)
            .background(Color.black)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.yellow.opacity(0.5), lineWidth: 1))
            .padding(30)
            .shadow(color: .black, radius: 20)
        }
    }
    
    func featureRow(icon: String, text: String) -> some View {
        HStack {
            Image(systemName: icon).foregroundStyle(.yellow).frame(width: 30)
            Text(text).font(.system(size: 14, design: .monospaced)).foregroundStyle(.white)
            Spacer()
        }.padding(.horizontal, 20)
    }
}
// --- GESTOR DE SONIDO ---
class SoundManager: ObservableObject {
    var chargePlayer: AVAudioPlayer?
    var failPlayer: AVAudioPlayer?
    var successPlayer: AVAudioPlayer?
    
    func prepareSounds() {
        chargePlayer = loadPlayer(file: "charge", loop: true)
        failPlayer = loadPlayer(file: "power_down", loop: false)
        successPlayer = loadPlayer(file: "success", loop: false)
    }
    
    private func loadPlayer(file: String, loop: Bool) -> AVAudioPlayer? {
        let path = Bundle.main.path(forResource: file, ofType: "mp3") ?? Bundle.main.path(forResource: file, ofType: "wav")
        guard let safePath = path else { return nil }
        do {
            let p = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: safePath))
            p.numberOfLoops = loop ? -1 : 0
            p.prepareToPlay()
            p.volume = 0
            return p
        } catch { return nil }
    }
    
    func startCharging() {
        failPlayer?.stop()
        successPlayer?.stop()
        chargePlayer?.currentTime = 0
        chargePlayer?.volume = 0.0
        chargePlayer?.rate = 1.0
        chargePlayer?.enableRate = true
        chargePlayer?.play()
    }
    
    func updateProximity(distance: CGFloat) {
        guard let player = chargePlayer else { return }
        let detectionRadius: CGFloat = 450.0 // Mismo radio que tu haptic bueno
        let normalized = 1.0 - Float(min(distance, detectionRadius) / detectionRadius)
        player.volume = max(0.05, normalized * 0.8)
        player.rate = 0.8 + (normalized * 0.7)
    }
    
    func playFail() {
        chargePlayer?.stop()
        failPlayer?.currentTime = 0
        failPlayer?.volume = 0.6
        failPlayer?.play()
    }
    
    func playSuccess() {
        chargePlayer?.stop()
        successPlayer?.currentTime = 0
        successPlayer?.volume = 1.0
        successPlayer?.play()
    }
    
    func stopAll() {
        chargePlayer?.stop()
        failPlayer?.stop()
        successPlayer?.stop()
    }
}
#Preview { ContentView() }
