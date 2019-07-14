//
//  UIView+RoundSpecificCorner.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 14/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit

extension UIView {
  
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
