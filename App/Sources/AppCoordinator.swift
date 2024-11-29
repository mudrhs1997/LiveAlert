
import UIKit
import Domain

final class AppCoordinator: Coordinator {
  // MARK: - Property

  var window: UIWindow?

  var childeren: [Coordinator] = []
  var navigationController = UINavigationController()

  init(window: UIWindow?) {
    self.window = window
  }

  // MARK: - Start

  func start() {
    startMainViewController()
  }

  private func startMainViewController() {
    guard let window else { return }
    let alarmCoordinator = AlarmCoordinator(navigationController: self.navigationController)
    alarmCoordinator.start()

    window.rootViewController = self.navigationController
    window.makeKeyAndVisible()
  }
}
