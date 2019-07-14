//
//  NSObject+ClassName.swift
//  CleanDi
//
//  Created by peerapat atawatana on 27/6/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import Foundation

extension NSObject {
  var className: String {
    return String(describing: type(of: self))
  }
  
  class var className: String {
    return String(describing: self)
  }
  
  class var classNameWithNav: String {
    return "\(className)Nav"
  }
}
