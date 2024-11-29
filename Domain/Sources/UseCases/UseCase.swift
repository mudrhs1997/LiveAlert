
import UIKit
import RxSwift


public final class UseCase {
  private let repository: Repository

  public init(repository: Repository) {
    self.repository = repository
  }

  public func getAlarmList() -> Observable<[Alarm]> {
    return repository.fetchAlarmList()
  }

  public func addAlarm(title: String,
                       body: String,
                       at date: DateComponents) -> Observable<[Alarm]> {
    return repository
      .addAlarm(title: title, body: body, at: date)
      .concat(repository.fetchAlarmList())
  }

  public func editAlarm(withIdentifier identifier: UUID,
                        title: String,
                        body: String,
                        at date: DateComponents) -> Observable<[Alarm]> {
    return repository
      .editAlarm(withIdentifier: identifier, title: title, body: body, at: date)
      .concat(repository.fetchAlarmList())
  }

  public func removeAlarm() -> Observable<Bool> {
    return Observable.just(true)
  }
}
