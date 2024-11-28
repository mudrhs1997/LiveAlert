
import UIKit
import RxSwift


public final class UseCase {
  private let repository: Repository

  public init(repository: Repository) {
    self.repository = repository
  }

  public func fetchMovie() -> Observable<[Movie]> {
    return repository.fetchMovieList()
  }

  public func addAlarm() -> Observable<Bool> {
    return repository.addAlarm()
  }
}
