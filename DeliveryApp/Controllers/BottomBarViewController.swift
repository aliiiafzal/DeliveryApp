//
//  BottomBarViewController.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 09/05/2023.
//

import UIKit

class BottomBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 13.0, *) {
      configureTabBarUI()
    } else {
      // Fallback on earlier versions
    }
  }
  
  //MARK: - HELPER
  @available(iOS 13.0, *)
  func configureTabBarUI() {
    let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
    tabBarAppearance.configureWithOpaqueBackground()
    tabBarAppearance.backgroundColor = Constants.tabBarColor
    self.tabBar.standardAppearance = tabBarAppearance
    if #available(iOS 15.0, *) {
      self.tabBar.scrollEdgeAppearance = tabBarAppearance
    } else {
      // Fallback on earlier versions
    }
  }
}
