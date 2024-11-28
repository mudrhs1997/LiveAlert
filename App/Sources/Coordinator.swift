
import UIKit

protocol Coordinator {
//  var parent: Coordinator { get set }
  var childeren: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }

  func start()
}

