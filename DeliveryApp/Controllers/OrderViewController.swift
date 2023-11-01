//
//  OrderViewController.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 09/05/2023.
//

import UIKit
import DropDown

class OrderViewController: UIViewController {
  
  //MARK: - OUTLETS
  @IBOutlet weak var chooseOrder: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var navView: UIView!
  @IBOutlet weak var searchOrder: UISearchBar!
  @IBOutlet weak var filterOrderText: UILabel!
  @IBOutlet weak var navBar: UIView!
  
  //MARK: - PROPERTIES
  let chooseOrderDropDown = DropDown()
  let orders = [OrderModel(id: "2401", userName: "Ali Afzal", userContact: "03486007399", deliveryDate: "2023-04-10", userAddress: "Main Street"),
                OrderModel(id: "2402", userName: "Umer Afzal", userContact: "0318071597", deliveryDate: "2023-06-12", userAddress: "Lahore Cantt"),
                OrderModel(id: "2403", userName: "Bilal Aslam", userContact: "03066571170", deliveryDate: "2023-12-09", userAddress: "Blue Area")]
  
  //MARK: - LIFECYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    if #available(iOS 13.0, *) {
      configureUIOfCell()
    } else {
      // Fallback on earlier versions
    }
  }
  
  //MARK: - ACTIONS
  @IBAction func orderDropDownPressed(_ sender: UIButton) {
    chooseOrderDropDown.show()
  }
  
  
  //MARK: - HELPERS
  func configureUI() {
    setupChooseArticleDropDown()
  }
  
  func setupChooseArticleDropDown() {
    chooseOrderDropDown.anchorView = chooseOrder
    chooseOrderDropDown.bottomOffset = CGPoint(x: 0, y: chooseOrder.bounds.height)
    
    chooseOrderDropDown.dataSource = [
      "All Order",
      "Delivered",
      "Requested By Rider",
      "Requested to ReAttempt"
    ]
    
    chooseOrderDropDown.selectionAction = { [weak self] (index, item) in
      self?.chooseOrder.setTitle(item, for: .normal)
      self?.filterOrderText.text = item
    }
  }
  
  @available(iOS 13.0, *)
  func configureUIOfCell() {
    searchOrder.searchTextField.backgroundColor = UIColor.white
    searchOrder.backgroundColor = Constants.searchBarColor
    chooseOrder.layer.cornerRadius = 10
    searchOrder.layer.cornerRadius = 10
    self.navigationController?.isNavigationBarHidden = true
    tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "orderListCell")
    tableView.dataSource = self
    tableView.delegate = self
    let shadowPath = UIBezierPath(rect: navView.bounds)
    navView.layer.masksToBounds = false
    navView.layer.shadowColor = UIColor.black.cgColor
    navView.layer.shadowOffset = CGSizeMake(0.0, 5.0)
    navView.layer.shadowOpacity = 0.3
    navView.layer.shadowPath = shadowPath.cgPath
  }
}

//MARK: - UITABLEVIEWDATASOURCE
extension OrderViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return orders.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.text = "  Order : #" + orders[section].id
    label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
    label.textColor = .red
    label.sizeToFit()
    return label
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let list = orders[indexPath.section]
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.orderListCellIdentifier, for: indexPath) as! OrderTableViewCell
    cell.nameOfUser.text = list.userName
    cell.contactOfUser.text = list.userContact
    cell.deliveryDate.text = list.deliveryDate
    cell.userAddress.text = list.userAddress
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return orders[section].id
  }
}

//MARK: - UITABLEVIEWDELEGATE
extension OrderViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30.0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
