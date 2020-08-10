//
//  AddRecordViewController.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 12/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class AddRecordViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var categoryPicker: UIPickerView!
    //uninstall
    //var accountPicker: UIPickerView!
    var expenseCategoriesList: [Currency] = [currency_1,currency_2,currency_3]
    var incomeCategoriesList: [Currency] = [currency_1,currency_2,currency_3]
    var currentUid = ""
    var record: Record!
    var model: AddRecordModel = Facade.share.model.addRecordModel
    var recordNumber:Int = 0
    //dateSource
    var pickViewDataSource:[String] = [currency_1.name,currency_2.name,currency_3.name]
    
    @IBOutlet weak var directionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: PickerBasedTextField!
    @IBOutlet weak var categoryTextField: PickerBasedTextField!
    @IBOutlet weak var prefixLabel: UILabel!
    
    // MARK: add record
    @IBAction func addRecordPressed(_ sender: Any) {
        // validation
        guard amountTextField.text != "" && amountTextField.text != "0" else {
            let alert = UIAlertController(title: "Error", message: "You should enter the amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        model.money = amountTextField.text!.getDoubleFromLocal()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        if let date = formatter.date(from: dateTextField.text!) {
            model.date = date
        }

//
        if model.id == nil {

            record = Record(id: recordNumber + 1, name: model.name ?? defaultCurrency.name, money: model.money, currency: expenseCategoriesList[model.index], date: model.date, direction: model.direction)
        }
        record.money = amountTextField.text!.getDoubleFromLocal()
        record.date = model.date
        
        if currentUid == "" {
            record.saveIt(Id: recordNumber + 1, Name: model.name ?? defaultCurrency.name, Money: model.money, Currency: expenseCategoriesList[model.index], Date: model.date, Direction: model.direction )
            record.retrieveIt()
        }
        else {
            let i : Int = Int(currentUid)! - 1
            model.recordList[i].id = i + 1
            model.recordList[i].name = model.name ?? defaultCurrency.name
            model.recordList[i].money = model.money
            model.recordList[i].currency = expenseCategoriesList[model.index]
            model.recordList[i].date = model.date
            model.recordList[i].direction = model.direction
        }
        
        
        

        //navigationController?.popViewController(animated: true)
        print("currentUid is \(currentUid)")
        
        model.recordListSorted = model.recordList.sorted(by:
            {$0.date < $1.date}
        )
        
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
        self.navigationController?.tabBarController?.selectedIndex = 1 // (第一个控制器)
        self.navigationController?.popToRootViewController(animated: true)
    }
    //uninstalled
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var reportingSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.money = 0
        model.date = Date()
        model.id = nil
        
        setupSegmentedController()
        
        adjustIndex()
        
        let formatterNumber = NumberFormatter()
        formatterNumber.minimumFractionDigits = 0
        formatterNumber.maximumFractionDigits = 2
        print("recordNumber is :\(recordNumber)"  )
        print("currentUID is : \(currentUid)" )
        
        // MARK:初始化UIPickerView
        
        // datePicker
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateTextField.text = formatter.string(from: Date())

        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.date = Date()
        datePicker.backgroundColor = UIColor.white
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        dateTextField.delegate = self
        
        
        //UIPicker Button Set up
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor.black
        toolBar2.sizeToFit()

        let doneButton2 = UIBarButtonItem(title: "Done",
                                          style: UIBarButtonItem.Style.plain,
                                          target: self,
                                          action: #selector(AddRecordViewController.donePicker))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                           target: nil,
                                           action: nil)
        toolBar2.setItems([spaceButton2, spaceButton2, doneButton2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        dateTextField.inputAccessoryView = toolBar2
        
        //categoryPicker
        let frame = self.view.frame
        let catFrame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 216)
        categoryPicker = UIPickerView(frame: catFrame)
        categoryPicker.backgroundColor = UIColor.white
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        categoryTextField.inputView = categoryPicker
        categoryTextField.delegate = self
        
        directionFieldConfig()
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: "Done",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(AddRecordViewController.donePicker))
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        categoryTextField.inputAccessoryView = toolBar

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: Set up UIPickerView
    
    //选择框列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //选择框行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPicker {
            
            if directionSegmentedControl.selectedSegmentIndex == 0 {
                return expenseCategoriesList[row].name
            } else {
                return incomeCategoriesList[row].name
            }
        
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPicker {
            model.direction = directionSegmentedControl.selectedSegmentIndex
            if model.direction == 0 {
                model.expenseIndex = row
                categoryTextField.text = expenseCategoriesList[row].name
            } else {
                model.incomeIndex = row
                categoryTextField.text = incomeCategoriesList[row].name
            }
        }
        
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField is PickerBasedTextField {
            let textField2 = textField as! PickerBasedTextField
            textField2.border.borderColor = UIColor.myAppBlue.cgColor
            textField2.textColor = UIColor.myAppBlue
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField is PickerBasedTextField {
            let textField2 = textField as! PickerBasedTextField
            textField2.border.borderColor = UIColor.black.cgColor
            textField2.textColor = UIColor.black
        }

    }
    
    // Done Button
    @objc func donePicker() {
        amountTextField.becomeFirstResponder()
        if directionSegmentedControl.selectedSegmentIndex == 0 {
            
            prefixLabel.text = "-" + expenseCategoriesList[model.expenseIndex].name
            prefixLabel.textColor = UIColor.myAppBlack
            model.name = expenseCategoriesList[model.expenseIndex].name
            model.index = model.expenseIndex
            model.direction = 0
            categoryPicker.selectRow(model.expenseIndex, inComponent: 0, animated: false)
        } else {
            
            prefixLabel.text = "+" + incomeCategoriesList[model.incomeIndex].name
            prefixLabel.textColor = UIColor.myAppGreen
            model.name = incomeCategoriesList[model.incomeIndex].name
            model.index = model.incomeIndex
            model.direction = 1
            categoryPicker.selectRow(model.incomeIndex, inComponent: 0, animated: false)
        }
        
//        print(model.expenseIndex)
//        print(model.incomeIndex)
//        print(expenseCategoriesList[model.expenseIndex].name)
//        print(incomeCategoriesList[model.incomeIndex].name)
    }
    
    // MARK: Set up SegmentController
    func setupSegmentedController() {
        guard expenseCategoriesList.count > 0 else {
                    let errorDesc = """
        You should have at least one expense category.
        Go to Settings > Categories and add an 'Expense' category.
        """
                    let alert = UIAlertController(title: "Error",
                                                  message: errorDesc,
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    present(alert, animated: true, completion: nil)

                    return
                }

                guard incomeCategoriesList.count > 0 else {
                    let errorDesc = """
        You should have at least one income category.
        Go to Settings > Categories and add an 'Income' category.
        """
                    let alert = UIAlertController(title: "Error",
                                                  message: errorDesc,
                                                  preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (_: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    present(alert, animated: true, completion: nil)

                    return
                }
    }
    
    // MARK: Useless so far
    func adjustIndex() {
        if model.incomeIndex >= incomeCategoriesList.count {
            model.incomeIndex = 0
        }

        if model.expenseIndex >= expenseCategoriesList.count {
            model.expenseIndex = 0
        }

    }
    
    // MARK: directionField config
    
    func directionFieldConfig() {
        // directionField config
        directionSegmentedControl.addTarget(self, action: #selector(directionChanged(_:)), for: .valueChanged)
        //初始,之后要设置
        //directionSegmentedControl.selectedSegmentIndex = Int.random(in: 0...1)
        directionSegmentedControl.selectedSegmentIndex = 0
        model.direction = 0
        if directionSegmentedControl.selectedSegmentIndex == 0 {
                    categoryTextField.text = (expenseCategoriesList.count > 0) ? expenseCategoriesList[model.expenseIndex].name : ""
        //            if model.expenseIndex <= categoryPicker.numberOfRows(inComponent: 0) {
                    categoryPicker.selectRow(model.expenseIndex, inComponent: 0, animated: false)
        //            }
            prefixLabel.text = "-" + expenseCategoriesList[model.expenseIndex].name
                    prefixLabel.textColor = UIColor.myAppBlack
                } else {
                    categoryTextField.text = (incomeCategoriesList.count > 0) ? incomeCategoriesList[model.incomeIndex].name : ""
        //            if model.incomeIndex <= categoryPicker.numberOfRows(inComponent: 0) {
                        categoryPicker.selectRow(model.incomeIndex, inComponent: 0, animated: false)
        //            }
            prefixLabel.text = "+" + incomeCategoriesList[model.incomeIndex].name
                    prefixLabel.textColor = UIColor.myAppGreen
                }
       
    }
    
    //每一次改变segmentcontroller
    @objc func directionChanged(_ sender: UISegmentedControl) {
        model.direction = directionSegmentedControl.selectedSegmentIndex
        categoryPicker.reloadAllComponents()
        if directionSegmentedControl.selectedSegmentIndex == 0 {
            categoryTextField.text = expenseCategoriesList[model.expenseIndex].name
            prefixLabel.text = "-" + expenseCategoriesList[model.expenseIndex].name
            prefixLabel.textColor = UIColor.myAppBlack

            categoryPicker.selectRow(model.expenseIndex, inComponent: 0, animated: false)
        } else {
            categoryTextField.text = incomeCategoriesList[model.incomeIndex].name
            prefixLabel.text = "+" + incomeCategoriesList[model.incomeIndex].name
            prefixLabel.textColor = UIColor.myAppGreen

            categoryPicker.selectRow(model.incomeIndex, inComponent: 0, animated: false)
        }


    }
    
    @objc public func datePickerValueChanged(sender: UIDatePicker) {

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        model.date = sender.date.dateOnly()

        dateTextField.text = dateFormatter.string(from: model.date)
    }
    
   
    
   
    

}
