//
//  LoginRequestModelType.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Moya

enum API {
  
  case login(requestModel: LoginRequestModelType)
  case getRoundStreakBonus(requestModel: GetRoundStreakRequestModelType)
}
