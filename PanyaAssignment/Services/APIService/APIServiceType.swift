//
//  LoginRequestModelType.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Foundation
import RxSwift

protocol APIServiceType {
  
  func rx_login(requestModel: LoginRequestModelType) -> Observable<UserModel>
  func rx_getRoundStreakBonus(requestModel: GetRoundStreakRequestModelType) -> Observable<[Int]>
}
