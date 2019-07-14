//
//  CreateAccountViewController.swift
//  PanyaAssignment
//
//  Created by peerapat atawatana on 9/7/2562 BE.
//  Copyright © 2562 Socket9. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import ZSwiftKit

class CreateAccountViewController: UIViewController, StoryboardInitializable {
  
  // MARK: IBOutlet
  
  @IBOutlet weak var createAccountTitleLabel: UILabel!
  @IBOutlet weak var emailFieldTitleLabel: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordFieldTitleLabel: UILabel!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var termsConditionLabel: UILabel!
  
  // MARK: Property 
  
  var viewModel: CreateAccountViewModelType!
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
    
    registerButton.rx.tap
      .withLatestFrom(
        Observable.combineLatest(
          emailTextField.rx.text.orEmpty,
          passwordTextField.rx.text.orEmpty))
      .bind(to: viewModel.inputs.loginTrigger)
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
    createAccountTitleLabel.text = L10n.CreateAccount.title
    emailFieldTitleLabel.text = L10n.CreateAccount.emailTitle
    passwordFieldTitleLabel.text = L10n.CreateAccount.passwordTitle
    registerButton.setTitle(L10n.CreateAccount.registerButton, for: .normal)
    termsConditionLabel.text = L10n.CreateAccount.terms
    emailTextField.layer.cornerRadius = 12
    passwordTextField.layer.cornerRadius = 12
    registerButton.layer.cornerRadius = registerButton.frame.height/2
    registerButton.clipsToBounds = true
  }
  
  // MARK: Private
}
