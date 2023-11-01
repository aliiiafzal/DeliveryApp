//
//  ExpenseViewController.swift
//  DeliveryApp
//
//  Created by Ali Afzal on 09/05/2023.
//

import UIKit

class ExpenseViewController: UIViewController {

  //MARK: - OUTLETS
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var reasonTextField: UITextView!
  @IBOutlet weak var expenseSaveButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var navView: UIView!
  
  //MARK: - PROPERTIES
  var datePicker: UIDatePicker = UIDatePicker()
  let expenseList = [ExpenseModel(id: "1", transferName: "Bill", transferSource: "Bank", transferDate: "2023-05-12", transferAmount: "200", reason: "My Reason"),ExpenseModel(id: "2", transferName: "Bill", transferSource: "Bank", transferDate: "2023-05-12", transferAmount: "200", reason: "My Reason"),ExpenseModel(id: "3", transferName: "Bill", transferSource: "Bank", transferDate: "2023-05-12", transferAmount: "200", reason: "My Reason")]
  
  //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
      configureUI()
    }
  
  //MARK: - ACTIONS
  @IBAction func dateTextFieldTapped(_ sender: UITextField) {
    datePicker.datePickerMode = .date
    if #available(iOS 13.4, *) {
      datePicker.preferredDatePickerStyle = .wheels
    } else {
      // Fallback on earlier versions
    }
    datePicker.backgroundColor = .white
    
    let toolbar = UIToolbar();
    toolbar.sizeToFit()
    let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: true)
    dateTextField.inputAccessoryView = toolbar
    dateTextField.inputView = datePicker
  }
  
  
  //MARK: - HELPERS
  func configureUI() {
    amountTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: amountTextField.frame.height))
    amountTextField.leftViewMode = .always
    amountTextField.setIcon(UIImage(named: "amount")!)
    amountTextField.layer.cornerRadius = 10
    amountTextField.borderStyle = .none
    amountTextField.layer.borderWidth = 1
    amountTextField.layer.borderColor = Constants.expenseTextFieldBorderColor
    
    dateTextField.tintColor = UIColor.lightGray
    dateTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: dateTextField.frame.height))
    dateTextField.leftViewMode = .always
    dateTextField.setIcon(UIImage(named: "date")!)
    dateTextField.layer.cornerRadius = 10
    dateTextField.borderStyle = .none
    dateTextField.layer.borderWidth = 1
    dateTextField.layer.borderColor = Constants.expenseTextFieldBorderColor
    
    reasonTextField.delegate = self
    reasonTextField.text = "reason"
    reasonTextField.textColor = UIColor.lightGray
    reasonTextField.layer.borderWidth = 1
    reasonTextField.layer.cornerRadius = 10
    reasonTextField.layer.borderColor = Constants.expenseTextFieldBorderColor
    
    expenseSaveButton.layer.cornerRadius = 10
    
    tableView.register(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "expenseListCell")
    tableView.delegate = self
    tableView.dataSource = self
    
    let shadowPath = UIBezierPath(rect: navView.bounds)
    navView.layer.masksToBounds = false
    navView.layer.shadowColor = UIColor.black.cgColor
    navView.layer.shadowOffset = CGSizeMake(0.0, 5.0)
    navView.layer.shadowOpacity = 0.3
    navView.layer.shadowPath = shadowPath.cgPath
  }
  
  @objc func donedatePicker(){
      let dateFormatter: DateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      let selectedDate: String = dateFormatter.string(from: datePicker.date)
      dateTextField.text = selectedDate
      self.view.endEditing(true)
  }
  
  @objc func cancelDatePicker(){
      self.view.endEditing(true)
  }
}

//MARK: - UITextViewDelegate
extension ExpenseViewController: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.textColor == UIColor.lightGray {
          textView.text = nil
          textView.textColor = UIColor.black
      }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
          textView.text = "reason"
          textView.textColor = UIColor.lightGray
      }
  }
}

//MARK: - UITABLEVIEWDATASOURCE
extension ExpenseViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return expenseList.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.clear
    return headerView
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let list = expenseList[indexPath.section]
    let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.expenseListCellIdentifier, for: indexPath) as! ExpenseTableViewCell
    cell.transferName.text = list.transferName
    cell.transferSource.text = list.transferSource
    cell.transferDate.text = list.transferDate
    cell.transferAmount.text = list.transferAmount
    cell.reason.text = list.reason
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return expenseList[section].id
  }
}

//MARK: - UITABLEVIEWDELEGATE
extension ExpenseViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10.0
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

