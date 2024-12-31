import UIKit
import Flutter
import GoogleMaps

@main
class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let apiKey = Bundle.main.infoDictionary?["GOOGLE_MAPS_API_KEY"] as? String ?? ""
        GMSServices.provideAPIKey(apiKey)
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}