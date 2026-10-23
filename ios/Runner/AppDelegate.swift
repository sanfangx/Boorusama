import UIKit
import Flutter
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var appPrivacyChannel: AppPrivacyChannel?
  private var webViewCookieChannel: WebViewCookieChannel?
  private var backgroundTask: UIBackgroundTaskIdentifier = .invalid

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }

    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    guard let registrar = engineBridge.pluginRegistry.registrar(
      forPlugin: "AppPrivacyChannel"
    ) else { return }
    appPrivacyChannel = AppPrivacyChannel(messenger: registrar.messenger())
    appPrivacyChannel?.register()
    webViewCookieChannel = WebViewCookieChannel(messenger: registrar.messenger())
    webViewCookieChannel?.register()
  }

  override func applicationDidEnterBackground(_ application: UIApplication) {
    super.applicationDidEnterBackground(application)
    // Request a short background task (~5 seconds) so in-flight SQLite transactions
    // and network/IO cleanups finish cleanly when the user switches apps, preventing
    // iOS watchdog kills without keeping the CPU awake in the background.
    if backgroundTask == .invalid {
      backgroundTask = application.beginBackgroundTask(withName: "BoorusamaSafeSuspend") { [weak self] in
        guard let self = self else { return }
        if self.backgroundTask != .invalid {
          application.endBackgroundTask(self.backgroundTask)
          self.backgroundTask = .invalid
        }
      }
      DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
        guard let self = self else { return }
        if self.backgroundTask != .invalid {
          application.endBackgroundTask(self.backgroundTask)
          self.backgroundTask = .invalid
        }
      }
    }
  }

  override func applicationWillEnterForeground(_ application: UIApplication) {
    if backgroundTask != .invalid {
      application.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }
    super.applicationWillEnterForeground(application)
  }
}
