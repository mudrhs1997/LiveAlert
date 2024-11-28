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

  func fetchMovieList() -> Observable<[Movie]>

  func addAlarm() -> Observable<Bool>
}

extension Repository {
//  init() { }
}
