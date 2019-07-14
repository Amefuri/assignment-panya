//
//  RoundStreakViewModel.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 9/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import RxSwift
import RxCocoa

struct DisplayRoundStreakInfo {
  var startRound: Int
  var hightlightRoundAmount: Int
  var isRecieved: Bool
  var heartGiven: Int
  var rewardType: StreakReward
}

protocol RoundStreakViewModelInputs {
    
}

protocol RoundStreakViewModelOutputs {
  var loading: Driver<Bool> { get }
  var roundStreakInfo: BehaviorSubject<[DisplayRoundStreakInfo]> { get }
  var consecutiveRoundCount: BehaviorSubject<Int> { get }
}

protocol RoundStreakViewModelCoordinates {
  var navigateBack: PublishSubject<Void> { get }
}

protocol RoundStreakViewModelType: ErrorAlertableViewModelType, BaseViewModelType {
  var inputs: RoundStreakViewModelInputs { get }
  var outputs: RoundStreakViewModelOutputs { get }
  var coordinates: RoundStreakViewModelCoordinates { get }
}

class RoundStreakViewModel: RoundStreakViewModelType, RoundStreakViewModelInputs, RoundStreakViewModelOutputs, RoundStreakViewModelCoordinates {
  
  // MARK: Property
  
  let countPerRow = 5
  let disposeBag = DisposeBag()
  
  // MARK: Init
    
  public init(apiService: APIServiceType = APIService(), userModel: UserModel) {
    
    let loading = ActivityIndicator()
    self.loading = loading.asDriver()
    let requestModel = GetRoundStreakRequestModel(token: userModel.accessToken)
    
    consecutiveRoundCount.onNext(userModel.consecutiveRoundCount)
    
    let getRoundStreakSignal = apiService
      .rx_getRoundStreakBonus(requestModel: requestModel)
      .trackActivity(loading)
      .materialize()
      .share(replay: 1)
    
    getRoundStreakSignal.elements()
      .map{Array(Set($0))}
      .map{$0.sorted()}
      .map{ elements in
        elements.enumerated().map{ (index, element) in
          let countPerRow = 5
          let startRound = (index*countPerRow)+1
          let divided = Float(userModel.consecutiveRoundCount)/Float(countPerRow*(index+1))
          let hightlightRoundAmount = divided > 1
            ? countPerRow
            : ( userModel.consecutiveRoundCount-(startRound-1))
          let isRecieved = hightlightRoundAmount >= countPerRow
          let rewardType: StreakReward = (index == elements.endIndex-1) ? .treasure : .heart
        return DisplayRoundStreakInfo(
          startRound: startRound,
          hightlightRoundAmount: hightlightRoundAmount,
          isRecieved: isRecieved,
          heartGiven: element,
          rewardType: rewardType)
        }}
      .bind(to: outputs.roundStreakInfo)
      .disposed(by: disposeBag)
   
    getRoundStreakSignal.errors()
      .map(errorToAlertable)
      .bind(to: error)
      .disposed(by: disposeBag)
  }
  
  // MARK: Private
  
  // MARK: Input
    
  // MARK: Output

  var error = PublishSubject<(title: String, message: String)>()
  var loading: Driver<Bool>
  var roundStreakInfo = BehaviorSubject<[DisplayRoundStreakInfo]>(value: [])
  var consecutiveRoundCount = BehaviorSubject<Int>(value: -1)
  
  // MARK: Coordinates
  
  let navigateBack = PublishSubject<Void>()
  
  // MARK: Input&Output&Coordinates
    
  public var outputs: RoundStreakViewModelOutputs { return self }
  public var inputs: RoundStreakViewModelInputs { return self }
  public var coordinates: RoundStreakViewModelCoordinates { return self }
}
