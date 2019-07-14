//
//  CreateAccountCoordinator.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 9/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit
import RxSwift

protocol CreateAccountInputsParamsType {
    
}

class CreateAccountCoordinator: BaseCoordinator<Void>, CreateAccountInputsParamsType {
  
  // MARK: Property

  // MARK: Public

  override func start() -> Observable<Void> {
    let window = self.window
    let viewModel = CreateAccountViewModel()
    let viewController = CreateAccountViewController.initFromStoryboard(name: Storyboard.main.identifier)
    
    viewController.viewModel = viewModel
    
    viewModel.coordinates.navigateToRoundStreak
      .map{ userModel -> RoundStreakCoordinator in
        let target = RoundStreakCoordinator(window: window, baseViewController: viewController, transitionType: .modal)
        target.userModel = userModel
        return target}
      .flatMapLatest(navigateToTarget)
      .subscribe()
      .disposed(by: disposeBag)
    
    transition(to: viewController)
    return .never()
  }

  // MARK: Private
    
  // MARK: InputParams

  public var inputsParams: CreateAccountInputsParamsType { return self }
}
