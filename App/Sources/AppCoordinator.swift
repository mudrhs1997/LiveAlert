
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
    let movieCoordinator = MovieCoordinator(navigationController: self.navigationController)
    movieCoordinator.start()

    window.rootViewController = self.navigationController
    window.makeKeyAndVisible()
  }
}
