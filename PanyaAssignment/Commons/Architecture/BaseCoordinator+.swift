//
//  BaseCoordinator+.swift
//  KKPPV-Prototype
//
//  Created by xAdmin on 25/4/2562 BE.
//

import UIKit

enum CoordinatorTransitionType {
  case push
  case modal
  case rootWindow
  case rootNavigation
  case rootInNavigation
}

extension BaseCoordinator {
  
  func transition(to destinationViewController: UIViewController) {
    switch transitionType {
    case .push:
      baseViewController.navigationController?.pushViewController(destinationViewController, animated: animated)
    case .modal:
      baseViewController.present(destinationViewController, animated: animated, completion: nil)
    case .rootWindow:
      window.rootViewController = destinationViewController
      window.makeKeyAndVisible()
    case .rootNavigation:
      (baseViewController as! UINavigationController).pushViewController(destinationViewController, animated: false)
    case .rootInNavigation:
      baseViewController.navigationController?.setViewControllers([destinationViewController], animated: false)
    }
  }
  
  func navigateBack() {
    switch transitionType {
    case .push:
      baseViewController.navigationController?.popViewController(animated: animated)
    case .modal:
      baseViewController.dismiss(animated: animated, completion: nil)
    case .rootWindow:
      break
    case .rootNavigation:
      break
    case .rootInNavigation:
      break
    }
  }
  
  func navigateBackToRoot() {
    switch transitionType {
    case .push:
      baseViewController.navigationController?.popToRootViewController(animated: animated)
    case .modal:
      baseViewController.dismiss(animated: animated, completion: nil)
    case .rootWindow:
      break
    case .rootNavigation:
      break
    case .rootInNavigation:
      break
    }
  }
  
}

