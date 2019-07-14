//
//  CreateAccountViewModel.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 9/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import RxSwift
import RxCocoa
import RxSwiftExt

protocol CreateAccountViewModelInputs {
  var loginTrigger: PublishSubject<(String, String)> { get }
}

protocol CreateAccountViewModelOutputs {
  var loading: Driver<Bool> { get }
}

protocol CreateAccountViewModelCoordinates {
  var navigateToRoundStreak: PublishSubject<UserModel> { get }
}

protocol CreateAccountViewModelType: ErrorAlertableViewModelType, BaseViewModelType {
  var inputs: CreateAccountViewModelInputs { get }
  var outputs: CreateAccountViewModelOutputs { get }
  var coordinates: CreateAccountViewModelCoordinates { get }
}

class CreateAccountViewModel: CreateAccountViewModelType, CreateAccountViewModelInputs, CreateAccountViewModelOutputs, CreateAccountViewModelCoordinates {
  
  // MARK: Property
  
  let disposeBag = DisposeBag()
  
  // MARK: Init
    
  public init(apiService: APIServiceType = APIService()) {
    
    let loading = ActivityIndicator()
    self.loading = loading.asDriver()
    
    let loginSignal = loginTrigger
      .map{
        LoginRequestModel(
          email: $0.0.trimmingCharacters(in: .whitespacesAndNewlines),
          password: $0.1.trimmingCharacters(in: .whitespacesAndNewlines))}
      .flatMapLatest { apiService
        .rx_login(requestModel: $0)
        .trackActivity(loading)
        .materialize()}
      .share(replay: 1)
    
    loginSignal.elements()
      .bind(to: coordinates.navigateToRoundStreak)
      .disposed(by: disposeBag)
    
    loginSignal.errors()
      .map(errorToAlertable)
      .bind(to: error)
      .disposed(by: disposeBag)
  }
  
  // MARK: Private
  
  // MARK: Input
  
  let loginTrigger = PublishSubject<(String, String)>()
  
  // MARK: Output

  var error = PublishSubject<(title: String, message: String)>()
  var loading: Driver<Bool>
  
  // MARK: Coordinates
  
  let navigateToRoundStreak = PublishSubject<UserModel>()
  
  // MARK: Input&Output&Coordinates
    
  public var outputs: CreateAccountViewModelOutputs { return self }
  public var inputs: CreateAccountViewModelInputs { return self }
  public var coordinates: CreateAccountViewModelCoordinates { return self }
}
