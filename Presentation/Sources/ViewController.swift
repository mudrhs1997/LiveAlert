
import UIKit
import RxSwift
import RxCocoa

public class ViewController: UIViewController {
  private var viewModel: ViewModel
  private var disposeBag = DisposeBag()

  let viewDidAppearTrigger = PublishSubject<Void>()

  let button: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.frame = CGRect(origin: .zero, size: .zero)
    button.setTitle("tap", for: .normal)
    button.backgroundColor = .green
    return button
  }()

  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.frame = CGRect(origin: .zero, size: .zero)
    tableView.backgroundColor = .black
    tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    return tableView
  }()

  public init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemBlue

    setView()
    setLayout()
    bind()


    viewDidAppearTrigger.onNext(())
  }

  func bind() {
    let input = ViewModel.Input(refresh: viewDidAppearTrigger)

    let output = viewModel.transform(from: input)

    output.movieList
      .observe(on: MainScheduler.instance)
      .bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { (row, movie, cell) in
        cell.setup(movie: movie)
      }
      .disposed(by: disposeBag)
  }

}

extension ViewController {
  func setView() {
    view.addSubview(button)
    view.addSubview(tableView)
  }

  func setLayout() {
    button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
    button.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    button.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    button.heightAnchor.constraint(equalToConstant: 100).isActive = true

    tableView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
}
