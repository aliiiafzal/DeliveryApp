//
//  OrderModel.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 11/05/2023.
//

import Foundation
struct OrderModel {
  let id: String
  let userName: String
  let userContact: String
  let deliveryDate: String
  let userAddress: String
  
  init(id: String, userName: String, userContact: String, deliveryDate: String, userAddress: String) {
    self.id = id
    self.userName = userName
    self.userContact = userContact
    self.deliveryDate = deliveryDate
    self.userAddress = userAddress
  }
}
