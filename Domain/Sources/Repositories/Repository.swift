//
//  Repository.swift
//  Domain
//
//  Created by 정명곤 on 10/30/24.
//

import UIKit
import RxSwift

public protocol Repository {

  init()

  func fetchAlarmList() -> Observable<[Alarm]>

  func addAlarm(title: String,
                body: String,
                at date: DateComponents) -> Observable<[Alarm]>

  func editAlarm(withIdentifier identifier: UUID,
                 title: String,
                 body: String,
                 at date: DateComponents) -> Observable<[Alarm]>

  func removeAlarms(with identifiers: [String]) -> Observable<[Alarm]>

}

extension Repository {
//  init() { }
}
