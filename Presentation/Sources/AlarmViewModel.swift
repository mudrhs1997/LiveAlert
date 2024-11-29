//
//  ViewModel.swift
//  Presentation
//
//  Created by 정명곤 on 10/29/24.
//  Copyright © 2024 CleanArchitecture. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain


public final class AlarmViewModel {
  private let useCase: UseCase
  private let disposeBag = DisposeBag()

  private let alarmRelay = BehaviorRelay<[Alarm]>(value: [])

  struct Input {
    let refresh: Observable<Void>
    let tapButton: Observable<Void>
  }

  struct Output {
    let alarmList: Observable<[Alarm]>
  }

  public init(useCase: UseCase) {
    self.useCase = useCase
  }

  func transform(from input: Input) -> Output {

    input.refresh
      .flatMap { [weak self] _ -> Observable<[Alarm]> in
        guard let self = self else { return Observable.just([]) }
        return useCase.getAlarmList()
      }
      .bind(to: alarmRelay)
      .disposed(by: disposeBag)

    input.tapButton
      .flatMap { [weak self] _ -> Observable<[Alarm]> in
        guard let self = self else { return Observable.just([])}
        return useCase.addAlarm(title: "custom title", body: "is this alarm add successfully?", at: DateComponents())
      }
      .bind(to: alarmRelay)
      .disposed(by: disposeBag)

    return Output(alarmList: alarmRelay.asObservable())
  }

}
