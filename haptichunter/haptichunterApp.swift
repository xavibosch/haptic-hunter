import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency
import AdSupport

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Inicializa los anuncios de Google
        MobileAds.shared.start(completionHandler: nil)
        return true
    }
}

@main
struct haptichunterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    // Retrasamos un segundo la petición para que la app cargue bien
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        ATTrackingManager.requestTrackingAuthorization { status in
                            switch status {
                            case .authorized:
                                print("Permiso concedido")
                            case .denied:
                                print("Permiso denegado")
                            default:
                                print("Estado desconocido")
                            }
                        }
                    }
                }
        }
    }
}
