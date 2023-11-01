//
//  OrderTableViewCell.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 12/05/2023.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
  
  //MARK: - OUTLETS
  @IBOutlet weak var nameOfUser: UILabel!
  @IBOutlet weak var contactOfUser: UILabel!
  @IBOutlet weak var deliveryDate: UILabel!
  @IBOutlet weak var userAddress: UILabel!
  @IBOutlet weak var locationButton: UIButton!
  @IBOutlet weak var assignedToRiderButton: UIButton!

  //MARK: - LIFECYCLE
  override func awakeFromNib() {
    super.awakeFromNib()
    configureCellUI()
  }
  
  //MARK: - HELPERS
  func configureCellUI() {
    locationButton.layer.cornerRadius = Constants.locationButtonCornerRadius
    assignedToRiderButton.layer.cornerRadius = Constants.assignedToRiderButtonCornerRadius
  }
}
