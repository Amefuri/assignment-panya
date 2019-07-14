//
//  LoginRequestModel.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Foundation

class LoginRequestModel: LoginRequestModelType {
  
  var email: String
  var password: String
  
  init(email: String, password: String) {
    self.email = email
    self.password = password
  }
}

extension LoginRequestModelType {
  
  func toHeader() -> [String: String] {
    return [:]
  }
  
  func toDictionary() -> [String : Any] {
    return ["email": email,
            "password": password]
  }
}
