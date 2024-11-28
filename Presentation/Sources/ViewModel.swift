//
//  ViewModel.swift
//  Presentation
//
//  Created by 정명곤 on 10/29/24.
//  Copyright © 2024 CleanArchitecture. All rights reserved.
//

import Foundation
import RxSwift
import Domain


public final class ViewModel {
  private let useCase: UseCase

  struct Input {
    let refresh: Observable<Void>
    let tapButton: Observable<Void>
  }

  struct Output {
    let movieList: Observable<[Movie]>
  }

  public init(useCase: UseCase) {
    self.useCase = useCase
  }

  func transform(from input: Input) -> Output {

    let movieList = input.refresh
                .flatMap { [weak self] _ -> Observable<[Movie]> in
                    guard let self = self else { return Observable.just([]) }
                  return useCase.fetchMovie()
                }

    return Output(movieList: movieList)
  }

}
