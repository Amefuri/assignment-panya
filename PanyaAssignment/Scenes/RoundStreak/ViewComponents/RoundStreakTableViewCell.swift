//
//  RoundStreakTableViewCell.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 14/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit

class RoundStreakTableViewCell: UITableViewCell {
  
  // MARK: IBOutlet
  
  @IBOutlet var roundLabels: [UILabel] = []
  @IBOutlet var roundCountLabels: [UILabel] = []
  @IBOutlet var roundBackgroundImageView: [UIImageView] = []
  @IBOutlet var roundContainerView: [UIView] = []
  @IBOutlet weak var rewardImageView: UIImageView!
  @IBOutlet weak var recievedImageView: UIImageView!
  @IBOutlet weak var heartCountLabel: UILabel!
  
  // MARK: Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    roundContainerView.forEach { (each) in
      each.clipsToBounds = true
    }
    if let firstRoundView = roundContainerView.first {
      firstRoundView.roundCorners([.topLeft, .bottomLeft], radius: firstRoundView.frame.height/2)
    }
    if let lastRoundView = roundContainerView.last {
      lastRoundView.roundCorners([.topRight, .bottomRight], radius: lastRoundView.frame.height/2)
    }
  }
  
  // MARK: Public
  
  public func configure(startRound: Int,
                        hightlightRoundAmount: Int,
                        isRecieved: Bool,
                        heartGiven: Int,
                        rewardType: StreakReward) {
    roundLabels.enumerated().forEach { (index, each) in
      let isHightlight = (index < hightlightRoundAmount)
      each.text = L10n.RoundStreak.round
      each.textColor = isHightlight ? .black : .white
    }
    roundCountLabels.enumerated().forEach { (index, each) in
      let isHightlight = (index < hightlightRoundAmount)
      each.text = "\(index + startRound)"
      if isHightlight {
        each.textColor = .yellow1
        each.alpha = 1
      } else {
        each.textColor = .white
        each.alpha = 0.5
      }
    }
    roundBackgroundImageView.enumerated().forEach { (index, each) in
      let isHightlight = (index < hightlightRoundAmount)
      each.image = isHightlight
        ? UIImage(asset: Asset.bgStreakInfoPink)
        : UIImage(asset: Asset.bgStreakInfoBlue)
    }
    recievedImageView.isHidden = !isRecieved
    heartCountLabel.text = "+\(heartGiven)"
    rewardImageView.image = (rewardType == .heart)
      ? UIImage(asset: Asset.icStreakHeartL)
      : UIImage(asset: Asset.icStreakChest)
    heartCountLabel.isHidden = !(rewardType == .heart)
    heartCountLabel.alpha = isRecieved ? 0.5 : 1
    rewardImageView.alpha = isRecieved ? 0.5 : 1
  }
}
