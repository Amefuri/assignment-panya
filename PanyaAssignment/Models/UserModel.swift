//
//  UserModel.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import ObjectMapper

class UserModel: Mappable {
  
  var name: String = ""
  var email: String = ""
  var consecutiveRoundCount: Int = 0
  var accessToken: String = ""
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map)
  {
    name                  <- map["name"]
    email                 <- map["email"]
    consecutiveRoundCount <- map["consecutive_round_count"]
    accessToken           <- map["access_token"]
  }
}

