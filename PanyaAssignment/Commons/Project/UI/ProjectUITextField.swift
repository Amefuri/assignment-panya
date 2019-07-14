//
//  ProjectUITextField.swift
//  CleanDi
//
//  Created by peerapat atawatana on 3/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit

class ProjectUITextField: UITextField {
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
  }
}

