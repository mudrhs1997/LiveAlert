
import Foundation
import Domain
import Common
import RxSwift
import RxCocoa

public final class RepositoryImpl: Repository {

  public init() { }

  // MARK: - Fetch movie list
  public func fetchMovieList() -> Observable<[Movie]> {
    guard let url = URL(string: "https://yts.mx/api/v2/list_movies.json") else { return Observable.just([]) }
    return URLRequest.get(url: url).map { (dto: ResponseDTO) in
      let movies = dto.data.movies.map {
        $0.toEntity()
      }
      return movies
    }.asObservable()
  }

  public func addAlarm() -> Observable<Bool> {
    let calendar = Calendar.current
    let newDate = calendar.date(byAdding: DateComponents(second: 5), to: .now)
    let components = calendar.component([.hour, .minute, .second], from: newDate!)
    return UNUserNotificationCenter.current().addNotificationRequest(by: components, id: UUID())
  }
}
