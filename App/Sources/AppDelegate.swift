
import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  let notificationCenter = UNUserNotificationCenter.current()

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    //  Asking permission to use notifications
    notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in

    }

    return true
  }

  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  }

}

