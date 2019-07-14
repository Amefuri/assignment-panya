//
//  AppCoordinator.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 9/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit
import RxSwift

protocol AppInputsParamsType {
    
}

class AppCoordinator: BaseCoordinator<Void> {
  
  override func start() -> Observable<Void> {
    let createAccountCoordinator = CreateAccountCoordinator(window: window)
    return coordinate(to: createAccountCoordinator)
  }
}
