//
//  ExpenseTableViewCell.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 12/05/2023.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

  //MARK: - OUTLETS
  @IBOutlet weak var transferName: UILabel!
  @IBOutlet weak var transferSource: UILabel!
  @IBOutlet weak var transferDate: UILabel!
  @IBOutlet weak var transferAmount: UILabel!
  @IBOutlet weak var reason: UILabel!
  
  //MARK: - LIFECYCLE
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
