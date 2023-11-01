//
//  HomeViewController.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 09/05/2023.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
  
  //MARK: - OUTLETS
  @IBOutlet weak var profileCardView: UIView!
  @IBOutlet weak var searchOrder: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var navView: UIView!
  
  //MARK: - PROPERTIES
  var captureSession = AVCaptureSession()
  var videoPreviewLayer: AVCaptureVideoPreviewLayer?
  var qrCodeFrameView: UIView?
  let orders = [HomeModel(id: "2401", userName: "Ali Afzal", userContact: "03486007399", deliveryDate: "2023-04-10", userAddress: "Main Street"),
  HomeModel(id: "2402", userName: "Umer Afzal", userContact: "0318071597", deliveryDate: "2023-06-12", userAddress: "Lahore Cantt"),
  HomeModel(id: "2403", userName: "Bilal Aslam", userContact: "03066571170", deliveryDate: "2023-12-09", userAddress: "Blue Area")]
  
  //MARK: - LIFECYCLE
  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 13.0, *) {
      configureUI()
    } else {
      // Fallback on earlier versions
    }
  }
  
  //MARK: - ACTIONS
  @IBAction func scanQRCode(_ sender: UIButton) {
    let scannerViewController = Constants.MAIN_STORYBOARD.instantiateViewController(withIdentifier: "scannerViewController") as! ScannerViewController
    self.navigationController?.pushViewController(scannerViewController, animated: true)
  }
  
  //MARK: - HELPERS
  @available(iOS 13.0, *)
  func configureUI() {
    profileCardView.layer.cornerRadius = Constants.profileCardCornerRadius
    searchOrder.searchTextField.backgroundColor = UIColor.white
    tableView.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "orderListCell")
    tableView.dataSource = self
    tableView.delegate = self
    self.navigationController?.isNavigationBarHidden = true
    
    let shadowPath = UIBezierPath(rect: navView.bounds)
    navView.layer.masksToBounds = false
    navView.layer.shadowColor = UIColor.black.cgColor
    navView.layer.shadowOffset = CGSizeMake(0.0, 5.0)
    navView.layer.shadowOpacity = 0.3
    navView.layer.shadowPath = shadowPath.cgPath
  }
  
}

//MARK: - UITABLEVIEWDATASOURCE
extension HomeViewController: UITableViewDataSource {
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
    let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.orderListCellIdentifier, for: indexPath) as! OrderTableViewCell
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
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30.0
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
