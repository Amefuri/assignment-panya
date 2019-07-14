//
//  RoundStreakViewController.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 9/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ZSwiftKit

class RoundStreakViewController: UIViewController, StoryboardInitializable {
  
  // MARK: IBOutlet
  
  @IBOutlet weak var tileLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var seperatorView: UIView!
  @IBOutlet weak var consecutivelyPlayedLabel: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var closeButton: UIButton!
  
  // MARK: Property 
  
  var viewModel: RoundStreakViewModelType!
  let disposeBag = DisposeBag()
  
  // MARK: View Life Cycle
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  func bindViewModel() {
    
    closeButton.rx.tap
      .bind(to: viewModel.coordinates.navigateBack)
      .disposed(by: disposeBag)
    
    viewModel.outputs.consecutiveRoundCount
      .subscribe(onNext: { [unowned self] count in
        self.setConsecutivePlayLabel(count: count)
      }).disposed(by: disposeBag)
    
    viewModel.outputs.roundStreakInfo
      .bind(to: tableView.rx.items(
        cellIdentifier: RoundStreakTableViewCell.className,
        cellType: RoundStreakTableViewCell.self)) { (row, element, cell) in
        cell.configure(
          startRound: element.startRound,
          hightlightRoundAmount: element.hightlightRoundAmount,
          isRecieved: element.isRecieved,
          heartGiven: element.heartGiven,
          rewardType: element.rewardType)}
      .disposed(by: disposeBag)
    
    viewModel.outputs.loading
      .drive(onNext: { [unowned self] isLoading in
        ZLoadingActivityView.action(in: self.view, isShow: isLoading)
      }).disposed(by: disposeBag)
    
    viewModel.error
      .subscribe(onNext: { [unowned self] error in
        Helper.Alert(
          view: self,
          title: error.title,
          message: error.message,
          confirmText: L10n.Global.ok)
      }).disposed(by: disposeBag)
  }
  
  // MARK: Setup
  
  func setupUI() {
    tileLabel.text = L10n.RoundStreak.title
    let text = L10n.RoundStreak.description
    let attributesString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
    let range1 = (text as NSString).range(of: L10n.RoundStreak.Description.hightlight1)
    attributesString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow1], range: range1)
    let range2 = (text as NSString).range(of: L10n.RoundStreak.Description.hightlight2)
    attributesString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow1], range: range2)
    descriptionLabel.attributedText = attributesString
  }
  
  // MARK: Private
  
  func setConsecutivePlayLabel(count: Int) {
    let text = L10n.RoundStreak.playRound(count)
    let attributesString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
    let range = (text as NSString).range(of: "\(count)")
    attributesString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.yellow1], range: range)
    consecutivelyPlayedLabel.attributedText = attributesString
  }
}
