//
//  LoginRequestModelType.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Foundation

protocol BaseAPIServiceRequestType {
  
  func toHeader() -> [String: String]
  func toDictionary() -> [String: Any]
}
