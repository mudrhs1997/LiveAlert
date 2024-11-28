//
//  TableViewCell.swift
//  Presentation
//
//  Created by 정명곤 on 10/29/24.
//  Copyright © 2024 CleanArchitecture. All rights reserved.
//

import UIKit
import RxSwift
import Domain

final class TableViewCell: UITableViewCell {
  static let identifier = "tableViewCell"

  private var disposeBag = DisposeBag()

  var thumbnail: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setView()
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup(movie: Movie) {
    self.titleLabel.text = movie.title
    if let imageURL = movie.coverImage {
      loadImage(from: imageURL)
        .observe(on: MainScheduler.instance)
        .bind(to: thumbnail.rx.image)
        .disposed(by: disposeBag)
    }
  }

  private func loadImage(from url: String) -> Observable<UIImage?> {
    guard let url = URL(string: url) else { return Observable.just(nil) }
    return Observable.create { observer in
      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error {
          observer.onError(error)
        } else if let data = data,
                  let image = UIImage(data: data) {
          observer.onNext(image)
          observer.onCompleted()
        }
      }
      task.resume()
      return Disposables.create {
        task.cancel()
      }
    }
  }
}

extension TableViewCell {

  func setView() {
    self.addSubview(thumbnail)
    self.addSubview(titleLabel)
  }

  func setLayout() {
    thumbnail.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    thumbnail.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    thumbnail.widthAnchor.constraint(equalToConstant: 50).isActive = true
    thumbnail.heightAnchor.constraint(equalToConstant: 50).isActive = true

    titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
  }

}
