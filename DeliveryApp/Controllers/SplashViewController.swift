//
//  SplashViewController.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 08/05/2023.
//

import UIKit

class SplashViewController: UIViewController {
  
  //MARK: - OUTLETS
  @IBOutlet weak var appName: UILabel!
  
  //MARK: - PROPERTIES
  var charIndex = 0.0
  
  //MARK: - LIFECYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - HELPERS
  func configureUI() {
    appName.text = ""
    var charIndex = 0.0
    let titleText = Constants.appName
    for letter in titleText {
      Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { (timer) in
        self.appName.text?.append(letter)
      }
      charIndex += 1
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      let vc = Constants.MAIN_STORYBOARD.instantiateViewController(withIdentifier: Constants.rootViewControllerIdentifier) as! BottomBarViewController
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

