//
//  DataSource.swift
//  Data
//
//  Created by 정명곤 on 10/30/24.
//

import Foundation
import UserNotifications
import Common
import RxSwift

final class DataSource {
  private let notificationCenter = UNUserNotificationCenter.current()

  public func getPendingNotificationRequests() -> Observable<[UNNotificationRequest]> {
    return Observable<[UNNotificationRequest]>.create { observer in
      let task = Task {
        let requests = await self.notificationCenter.pendingNotificationRequests()
        observer.onNext(requests)
      }
      return Disposables.create {
        task.cancel()
      }
    }
  }

  public func addNotificationRequestToCenter(withIdentifier identifier: UUID,
                                             title: String,
                                             body: String,
                                             at date: DateComponents) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = .default

    let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
//    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: <#T##TimeInterval#>, repeats: <#T##Bool#>)
    let request = UNNotificationRequest(identifier: identifier.uuidString, content: content, trigger: trigger)

    notificationCenter.add(request)
  }

  public func removeNotificationRequestFromCenter(with identifiers: [String]) {
    notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
  }
}
