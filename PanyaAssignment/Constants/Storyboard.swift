//
//  Storyboard.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 13/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Foundation

enum Storyboard {
  case main
  
  var identifier: String {
    switch self {
    case .main:
      return "Main"
    }
  }
}
