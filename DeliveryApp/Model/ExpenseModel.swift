//
//  ExpenseModel.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 12/05/2023.
//

import Foundation
struct ExpenseModel {
  let id: String
  let transferName: String
  let transferSource: String
  let transferDate: String
  let transferAmount: String
  let reason: String
  
  init(id: String, transferName: String, transferSource: String, transferDate: String, transferAmount: String, reason: String) {
    self.id = id
    self.transferName = transferName
    self.transferSource = transferSource
    self.transferDate = transferDate
    self.transferAmount = transferAmount
    self.reason = reason
  }
}
