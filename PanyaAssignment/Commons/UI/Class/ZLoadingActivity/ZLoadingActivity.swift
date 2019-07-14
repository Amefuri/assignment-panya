//
//  ZLoadingActivity.swift
//  CleanDi
//
//  Created by peerapat atawatana on 12/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit
import SnapKit

class ZLoadingActivityView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let bgView = UIView(frame: .zero)
    bgView.backgroundColor = .black
    bgView.alpha = 0
    self.addSubview(bgView)
    bgView.snp.makeConstraints { (maker) in
      maker.edges.equalToSuperview()
    }
    
    let blurEffect = UIBlurEffect(style: .prominent)
    let blurredEffectView = UIVisualEffectView(effect: blurEffect)
    self.addSubview(blurredEffectView)
    blurredEffectView.snp.makeConstraints { (maker) in
      maker.center.equalToSuperview()
      maker.width.height.equalTo(80)
    }
  
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    activityIndicator.color = .darkGray
    activityIndicator.startAnimating()
    blurredEffectView.contentView.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints { (maker) in
      maker.center.equalToSuperview()
    }
    
    blurredEffectView.layer.cornerRadius = 5
    blurredEffectView.clipsToBounds = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ZLoadingActivityView {
  
  static func action(in view: UIView, isShow: Bool) {
    if isShow {
      show(in: view)
    } else {
      hide(in: view)
    }
  }
  
  static func show(in view: UIView) {
    guard view.viewWithTag(9999) == nil else { return }
    let indicatorView = ZLoadingActivityView(frame: view.frame)
    indicatorView.tag = 9999
    view.addSubview(indicatorView)
  }
  
  static func hide(in view: UIView) {
    if let indicator = view.viewWithTag(9999) as? ZLoadingActivityView {
      indicator.removeFromSuperview()
    }
  }
}
