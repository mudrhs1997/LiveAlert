
import UIKit
import Presentation
import Domain
import Data

final class MovieCoordinator: Coordinator {
  // MARK: - Property
  var childeren: [Coordinator] = []
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  // MARK: - Start

  func start() {
    let repository = RepositoryImpl() // Data layer
    let useCase = UseCase(repository: repository) // Domain layer
    let viewModel = ViewModel(useCase: useCase) // Presentation layer
    let viewController = ViewController(viewModel: viewModel)

    navigationController.pushViewController(viewController, animated: true)
  }


}
