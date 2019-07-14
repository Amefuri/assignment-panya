//
//  LoginRequestModelType.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Moya
import Alamofire

extension API: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.panya.me/v2/test")!
  }
  
  var path: String {
    switch self {
    case .login(_):
      return "login"
    case .getRoundStreakBonus(_):
      return "streak-bonus"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login(_):
      return .post
    case .getRoundStreakBonus(_):
      return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
    case .login(let requestModel):
      return .requestParameters(parameters: requestModel.toDictionary(),
                                encoding: JSONEncoding.default)
    case .getRoundStreakBonus(_):
      return .requestParameters(parameters: [:],
                                encoding: JSONEncoding.default)
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .getRoundStreakBonus(let requestModel):
      return requestModel.toHeader()
    default:
      return [:]
    }
  }
}
