//
//  DisplayRecordViewController.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 12/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class DisplayRecordViewController: UIViewController {

    var record: Record!
    var model: AddRecordModel = Facade.share.model.addRecordModel
    var expenseCategoriesList: [Currency] = [currency_1,currency_2,currency_3]
    var incomeCategoriesList: [Currency] = [currency_1,currency_2,currency_3]
    var currentUid = ""
    
    @IBOutlet weak var prefixLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
//    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: "AddRecord") as? AddRecordViewController {
            controller.currentUid = String(record.id)
            navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataFilling()
    }
    
    func dataFilling(){
        
        record = model.recordListSorted[(Int(currentUid)! - 1)]
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        self.amountLabel.text = String("\(numberFormatter.string(from: NSNumber(value: record.money))!)")
        
        model.date = record.date
        model.id = record.id
        
        // datePicker
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        self.dateLabel.text = formatter.string(from: model.date)
        
        if model.recordListSorted[Int(currentUid
        )!-1].direction == 0 {
//            self.categoryLabel.text = (expenseCategoriesList.count > 0) ? expenseCategoriesList[model.expenseIndex].name : ""
            prefixLabel.text = "-" + model.recordListSorted[Int(currentUid
                )!-1].currency.name
            prefixLabel.textColor = UIColor.myAppBlack
        } else {
//            self.categoryLabel.text = (incomeCategoriesList.count > 0) ? incomeCategoriesList[model.incomeIndex].name : ""
            prefixLabel.text = "+" + model.recordListSorted[Int(currentUid
            )!-1].currency.name
            prefixLabel.textColor = UIColor.myAppGreen
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func setupUI() {
        self.dateLabel.textColor = .gray
        self.dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)

//        self.categoryLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)

        self.editButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.editButton.setTitleColor(.white, for: .normal)
        self.editButton.backgroundColor = UIColor(red: 27 / 255.0,
                                                  green: 163 / 255.0,
                                                  blue: 216 / 255.0,
                                                  alpha: 1)
    }
    
    

}
