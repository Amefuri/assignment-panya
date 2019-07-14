//
//  GetRoundStreakRequestModel.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Foundation

class GetRoundStreakRequestModel: GetRoundStreakRequestModelType {
  
  var token: String
  
  init(token: String) {
    self.token = token
  }
}

extension GetRoundStreakRequestModelType {
  
  func toHeader() -> [String: String] {
    return ["access-token": token]
  }
  
  func toDictionary() -> [String: Any] {
    return [:]
  }
}
