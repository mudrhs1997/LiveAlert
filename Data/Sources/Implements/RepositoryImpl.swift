
import Foundation
import Domain
import Common
import RxSwift
import RxCocoa
import UserNotifications

public final class RepositoryImpl: Repository {
  private let dataSource = DataSource()

  public init() { }

  // MARK: - Fetch alarm list
  public func fetchAlarmList() -> Observable<[Alarm]> {
    return dataSource.getPendingNotificationRequests().map { (requests: [UNNotificationRequest]) in
      let alarms = requests.map {
        Alarm(id: $0.identifier, content: $0.content.title, trigger: $0.trigger?.description)
      }
      return alarms
    }.asObservable()
  }

  // MARK: - Add alarm
  public func addAlarm(title: String,
                       body: String,
                       at date: DateComponents) -> Observable<[Alarm]> {
    dataSource.addNotificationRequestToCenter(withIdentifier: UUID(), title: title, body: body, at: date)
    return Observable.just([])
  }


  // MARK: - Edit alarm. Add exsiting alarm's UUID to edit.
  public func editAlarm(withIdentifier identifier: UUID,
                        title: String,
                        body: String,
                        at date: DateComponents) -> Observable<[Alarm]> {
    dataSource.addNotificationRequestToCenter(withIdentifier: identifier, title: title, body: body, at: date)
    return Observable.just([])
  }

  // MARK: - Remove Alarm. Remove all alarm in array by UUID.
  public func removeAlarms(with identifiers: [String]) -> Observable<[Alarm]> {
    dataSource.removeNotificationRequestFromCenter(with: identifiers)
    return Observable.just([])
  }
}
