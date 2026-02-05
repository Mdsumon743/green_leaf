import Flutter
import UIKit
import GoogleMaps   // ✅ ADD THIS

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // ✅ ADD THIS LINE
        GMSServices.provideAPIKey("AIzaSyDCp_EGIWaoVYOeML3Kl8YiPN1az3hV9WA")

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
