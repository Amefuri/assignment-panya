//
//  RoundStreakCoordinator.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 9/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit
import RxSwift

protocol RoundStreakInputsParamsType {
  var userModel: UserModel! { get }
}

class RoundStreakCoordinator: BaseCoordinator<Void>, RoundStreakInputsParamsType {
  
  // MARK: Property

  var userModel: UserModel!
  
  // MARK: Public

  override func start() -> Observable<Void> {
    let viewModel = RoundStreakViewModel(userModel: userModel)
    let viewController = RoundStreakViewController.initFromStoryboard(name: Storyboard.main.identifier)
    viewController.viewModel = viewModel
    
    transition(to: viewController)
   
    return viewModel.coordinates.navigateBack
      .do(onNext: { [weak self] _ in self?.navigateBack()})
  }

  // MARK: Private
    
  // MARK: InputParams

  public var inputsParams: RoundStreakInputsParamsType { return self }
}
