//
//  BaseViewModel.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import RxSwift

protocol BaseViewModelType {
  
  func errorToAlertable(error: Error) -> (title: String, message: String)
}

extension ErrorAlertableViewModelType {
  
  func errorToAlertable(error: Error) -> (title: String, message: String) {
    if let apiServiceError = error as? APIServiceErrorType {
      return (title: apiServiceError.name, message: apiServiceError.message)
    }
    return (title: "", message: error.localizedDescription)
  }
}

protocol ErrorAlertableViewModelType {
  
  var error: PublishSubject<(title: String, message: String)> { get set }
}


