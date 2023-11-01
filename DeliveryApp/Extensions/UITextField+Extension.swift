//
//  UITextField+Extension.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 12/05/2023.
//

import Foundation
import UIKit

extension UITextField {
  func setIcon(_ image: UIImage) {
    let iconView = UIImageView(frame:
                                CGRect(x: 5, y: 15, width: 25, height: 25))
    iconView.image = image
    let iconContainerView: UIView = UIView(frame:
                                            CGRect(x: 0, y: 0, width: 55, height: 55))
    iconContainerView.addSubview(iconView)
    leftView = iconContainerView
    leftViewMode = .always
  }
}
