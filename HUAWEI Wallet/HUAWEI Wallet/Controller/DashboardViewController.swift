//
//  DashboardViewController.swift
//  HUAWEI Wallet
//
//  Created by Zhangwei Chen on 26/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var recentRecord: UILabel!
    
    
    @IBOutlet weak var currencyAIncome: UILabel!
    
    @IBOutlet weak var currencyAIncomeLabel: UILabel!
    
    @IBOutlet weak var currencyAExpend: UILabel!
    
    @IBOutlet weak var currencyAExpendLabel: UILabel!
    
    
    @IBOutlet weak var currencyBIncome: UILabel!
    
    @IBOutlet weak var currencyBIncomeLabel: UILabel!
    
    @IBOutlet weak var currencyBExpend: UILabel!
    
    @IBOutlet weak var currencyBExpendLabel: UILabel!
    
    
    @IBOutlet weak var currencyCIncome: UILabel!
    
    @IBOutlet weak var currencyCIncomeLabel: UILabel!
    
    @IBOutlet weak var currencyCExpend: UILabel!
    
    @IBOutlet weak var currencyCExpendLabel: UILabel!
    
    
    @IBOutlet weak var goAnalysis: UIButton!
    
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    
    @IBOutlet weak var ethereumLabel: UILabel!
    
    
    @IBOutlet weak var rippleLabel: UILabel!
    
    
    
    @IBOutlet weak var recentRecordTitle: UILabel!
    
    var bitcoinRecordIncome = [Double]()
    var bitcoinRecordExpend = [Double]()
    var ethereumRecordIncome = [Double]()
    var ethereumRecordExpend = [Double]()
    var rippleRecordIncome = [Double]()
    var rippleRecordExpend = [Double]()
    var model: AddRecordModel = Facade.share.model.addRecordModel
    
    
    
    //Convert date to string
    func dateToString(_ date:Date, dateFormat:String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    
    //Get the latest record
    func retrieveRecentData() {
        let userDefaults = UserDefaults.standard
        let i = model.recordList.count
        do {
            let recentRecordData = try userDefaults.getObject(forKey: "recordSave\(i)", castTo: Record.self)
            let date = dateToString(recentRecordData.date)
            let InOrEx = recentRecordData.direction
            let textAttribute1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
            let textAttribute2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
            let text1 = NSMutableAttributedString(string:" Coin name: ", attributes:textAttribute1)
            let text2 = NSMutableAttributedString(string:recentRecordData.currency.name + "\n", attributes:textAttribute2)
            let text3 = NSMutableAttributedString(string:" Date: ", attributes:textAttribute1)
            let text4 = NSMutableAttributedString(string:date + "\n", attributes:textAttribute2)
            let text5 = NSMutableAttributedString(string:" Amount: ", attributes:textAttribute1)
            text1.append(text2)
            text1.append(text3)
            text1.append(text4)
            text1.append(text5)
            if InOrEx == 1 {
                let text6 = NSMutableAttributedString(string:String(recentRecordData.money), attributes:textAttribute2)
                text1.append(text6)
                recentRecord.backgroundColor = UIColor.init(displayP3Red: 0.4157, green: 0.498, blue: 0.5686, alpha: 1)
            } else if InOrEx == 0 {
                let text6 = NSMutableAttributedString(string:"-" + String(recentRecordData.money), attributes:textAttribute2)
                text1.append(text6)
                recentRecord.backgroundColor = UIColor.init(displayP3Red: 0.1569, green: 0.4667, blue: 0.4588, alpha: 1)
            }
            recentRecord.layer.masksToBounds = true
            recentRecord.layer.cornerRadius = 10
            recentRecord.layer.borderColor = UIColor.init(red: 0.3725, green: 0.3843, blue: 0.4471, alpha: 1).cgColor
            recentRecord.attributedText = text1
        }
        catch {
            recentRecord.layer.masksToBounds = true
            recentRecord.layer.cornerRadius = 10
            recentRecord.layer.borderColor = UIColor.init(red: 0.3725, green: 0.3843, blue: 0.4471, alpha: 1).cgColor
            recentRecord.text = "No Record"
            print("no data exist")
        }
    }
    
    
    //Get last five income record
    func lastFiveIncomeRecord(coinName:String) -> Array<Double> {
        let userDefaults = UserDefaults.standard
        var i = model.recordList.count
        var recordData = [Double]()
        var data = 0.0
        while i > 0{
            do {
                let recordRead = try userDefaults.getObject(forKey: "recordSave\(i)", castTo: Record.self)
                if recordRead.currency.name == coinName {
                    if recordRead.direction == 1 {
                        data = recordRead.money
                        recordData.append(data)
                    }
                }
                i -= 1
        } catch {
                print(error.localizedDescription)
            }
            
    }
        var lastFiveIncomeData = [Double]()
        if recordData.count == 0 {
            lastFiveIncomeData.append(0)
        }else if recordData.count == 1 {
            lastFiveIncomeData.append(recordData[0])
        } else if recordData.count < 5 {
            for x in stride(from: recordData.count, to: 0, by: -1) {
                lastFiveIncomeData.append(recordData[x-1])
            }
        } else {
            var y = 4
            while y >= 0 {
                lastFiveIncomeData.append(recordData[y])
                y -= 1
            }
        }
        
        
        return lastFiveIncomeData
       
    }
    
    
    //Get last five enpend record
    func lastFiveExpendRecord(coinName:String) -> Array<Double> {
        let userDefaults = UserDefaults.standard
        var i = model.recordList.count
        var recordData = [Double]()
        var data = 0.0
        while i > 0{
            do {
                let recordRead = try userDefaults.getObject(forKey: "recordSave\(i)", castTo: Record.self)
                if recordRead.currency.name == coinName {
                    if recordRead.direction == 0 {
                        data = recordRead.money
                        recordData.append(data)
                    }
                }
                i -= 1
        } catch {
                print(error.localizedDescription)
            }
    }
        var lastFiveExpendData = [Double]()
        if recordData.count == 0 {
        lastFiveExpendData.append(0)
        } else if recordData.count == 1 {
            lastFiveExpendData.append(recordData[0])
        } else if recordData.count < 5 {
            for x in stride(from: recordData.count, to: 0, by: -1) {
                lastFiveExpendData.append(recordData[x-1])
            }
        } else if recordData.count >= 5 {
            var y = 4
            while y >= 0 {
                lastFiveExpendData.append(recordData[y])
                y -= 1
                }
        }
        return lastFiveExpendData
    }

    
    //Calculate summary of coin
    func coinDataSum(coinName:String) -> (incomeSum:Double, expandSum:Double, dateData:String) {
        let userDefaults = UserDefaults.standard
        var i = 0
        var incomeSum = 0.0
        var expandSum = 0.0
        var dateData = ""
        
        while i < model.recordList.count{
            do {
                let recordRead = try userDefaults.getObject(forKey: "recordSave\(i+1)", castTo: Record.self)
                if recordRead.currency.name == coinName {
                    if recordRead.direction == 1 {
                        incomeSum = incomeSum + recordRead.money
                        dateData = dateToString(recordRead.date)
                    } else if recordRead.direction == 0 {
                        expandSum = expandSum + recordRead.money
                        dateData = dateToString(recordRead.date)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
                i += 1
            }
            return (incomeSum,expandSum,dateData)
        }
    
    
    //Pass data to analysis page
    override func prepare(for segue: UIStoryboardSegue, sender: Any? ) {
        
        if let vc = segue.destination as? AnalysisViewController {
            
            let titles = ["Bitcoin","Ethereum","Ripple"]
            var yDataIncome = [Double]()
            var yDataExpend = [Double]()

            for n in 0...2 {
                let incomeData = coinDataSum(coinName: titles[n]).incomeSum
                yDataIncome.append(incomeData)
                let expendData = coinDataSum(coinName: titles[n]).expandSum
                yDataExpend.append(expendData)
                }
            
            bitcoinRecordIncome = lastFiveIncomeRecord(coinName: "Bitcoin")
            bitcoinRecordExpend = lastFiveExpendRecord(coinName: "Bitcoin")
            ethereumRecordIncome = lastFiveIncomeRecord(coinName: "Ethereum")
            ethereumRecordExpend = lastFiveExpendRecord(coinName: "Ethereum")
            rippleRecordIncome = lastFiveIncomeRecord(coinName: "Ripple")
            rippleRecordExpend = lastFiveExpendRecord(coinName: "Ripple")

            vc.yDataIncome = yDataIncome
            vc.yDataExpend = yDataExpend
            
            vc.titles = titles
            
            vc.yDataAIncome = bitcoinRecordIncome
            vc.yDataAExpend = bitcoinRecordExpend
            
            vc.yDataBIncome = ethereumRecordIncome
            vc.yDataBExpend = ethereumRecordExpend
            
            vc.yDataCIncome = rippleRecordIncome
            vc.yDataCExpend = rippleRecordExpend
            
            print(rippleRecordIncome)
            print(ethereumRecordIncome)
            print(bitcoinRecordIncome)
            

        }
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(displayP3Red: 0.8784, green: 0.8745, blue: 0.8667, alpha: 1)
        currencyAIncome.text = String(coinDataSum(coinName: "Bitcoin").incomeSum)
        currencyAIncome.layer.masksToBounds = true
        currencyAIncome.layer.cornerRadius = 10
        currencyAIncome.layer.backgroundColor = UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1).cgColor
        currencyAIncome.textColor = UIColor.white
        currencyAIncome.sizeToFit()
        
        currencyAIncomeLabel.layer.masksToBounds = true
        currencyAIncomeLabel.layer.cornerRadius = 5
        currencyAIncomeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        
        currencyAExpend.text = String(coinDataSum(coinName: "Bitcoin").expandSum)
        currencyAExpend.layer.masksToBounds = true
        currencyAExpend.layer.cornerRadius = 10
        currencyAExpend.sizeToFit()
        
        currencyAExpend.layer.backgroundColor = UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1).cgColor
        currencyAExpend.textColor = UIColor.white
        currencyAExpendLabel.layer.masksToBounds = true
        currencyAExpendLabel.layer.cornerRadius = 5
        currencyAExpendLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)


       
        currencyBIncome.text = String(coinDataSum(coinName: "Ethereum").incomeSum)
        currencyBIncome.layer.masksToBounds = true
        currencyBIncome.layer.cornerRadius = 10
        currencyBIncome.layer.backgroundColor = UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1).cgColor
        currencyBIncome.textColor = UIColor.white
        currencyBIncome.sizeToFit()
        
        currencyBIncomeLabel.layer.masksToBounds = true
        currencyBIncomeLabel.layer.cornerRadius = 5
        currencyBIncomeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        
        
        currencyBExpend.text = String(coinDataSum(coinName: "Ethereum").expandSum)
        currencyBExpend.layer.masksToBounds = true
        currencyBExpend.layer.cornerRadius = 10

        currencyBExpend.layer.backgroundColor =  UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1).cgColor
        currencyBExpend.textColor = UIColor.white
        currencyBExpend.sizeToFit()
        
        currencyBExpendLabel.layer.masksToBounds = true
        currencyBExpendLabel.layer.cornerRadius = 0
        currencyBExpendLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

       
        
        currencyCIncome.text = String(coinDataSum(coinName: "Ripple").incomeSum)
        currencyCIncome.layer.masksToBounds = true
        currencyCIncome.layer.cornerRadius = 10

        currencyCIncome.layer.backgroundColor = UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1).cgColor
        currencyCIncome.textColor = UIColor.white
        currencyCIncome.sizeToFit()
        
        currencyCIncomeLabel.layer.masksToBounds = true
        currencyCIncomeLabel.layer.cornerRadius = 5
        currencyCIncomeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        
        
        currencyCExpend.text = String(coinDataSum(coinName: "Ripple").expandSum)
        currencyCExpend.layer.masksToBounds = true
        currencyCExpend.layer.cornerRadius = 10
        currencyCExpend.layer.backgroundColor = UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1).cgColor
        currencyCExpend.textColor = UIColor.white
        currencyCExpendLabel.layer.masksToBounds = true
        currencyCExpend.sizeToFit()
        
        currencyCExpendLabel.layer.cornerRadius = 5
        currencyCExpendLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        
        
        bitcoinLabel.layer.masksToBounds = true
        bitcoinLabel.layer.cornerRadius = 5
        bitcoinLabel.layer.backgroundColor = UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1).cgColor
        bitcoinLabel.textColor = UIColor.white
        bitcoinLabel.sizeToFit()
        
        ethereumLabel.layer.masksToBounds = true
        ethereumLabel.layer.cornerRadius = 5
        ethereumLabel.layer.backgroundColor = UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1).cgColor
        ethereumLabel.textColor = UIColor.white
        
        rippleLabel.layer.masksToBounds = true
        rippleLabel.layer.cornerRadius = 5
        rippleLabel.layer.backgroundColor = UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1).cgColor
        rippleLabel.textColor = UIColor.white
        
        

        recentRecordTitle.textColor = UIColor(red: 0.0941, green: 0.4549, blue: 0.8039, alpha: 1)
        
        
        goAnalysis.layer.masksToBounds = true
        goAnalysis.layer.cornerRadius = 5
        goAnalysis.layer.backgroundColor = UIColor(red: 0.0941, green: 0.4549, blue: 0.8039, alpha: 1).cgColor
        goAnalysis.setTitleColor(UIColor.white, for: UIControl.State.normal)
        
        
        retrieveRecentData()

        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
          view.backgroundColor = UIColor.init(displayP3Red: 0.8784, green: 0.8745, blue: 0.8667, alpha: 1)
          currencyAIncome.text = String(coinDataSum(coinName: "Bitcoin").incomeSum)
          currencyAIncome.layer.masksToBounds = true
          currencyAIncome.layer.cornerRadius = 10
          currencyAIncome.layer.backgroundColor = UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1).cgColor
          currencyAIncome.textColor = UIColor.white
          currencyAIncome.sizeToFit()
          
          currencyAIncomeLabel.layer.masksToBounds = true
          currencyAIncomeLabel.layer.cornerRadius = 5
          currencyAIncomeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

          
          currencyAExpend.text = String(coinDataSum(coinName: "Bitcoin").expandSum)
          currencyAExpend.layer.masksToBounds = true
          currencyAExpend.layer.cornerRadius = 10
          currencyAExpend.sizeToFit()
          
          currencyAExpend.layer.backgroundColor = UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1).cgColor
          currencyAExpend.textColor = UIColor.white
          currencyAExpendLabel.layer.masksToBounds = true
          currencyAExpendLabel.layer.cornerRadius = 5
          currencyAExpendLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)


         
          currencyBIncome.text = String(coinDataSum(coinName: "Ethereum").incomeSum)
          currencyBIncome.layer.masksToBounds = true
          currencyBIncome.layer.cornerRadius = 10
          currencyBIncome.layer.backgroundColor = UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1).cgColor
          currencyBIncome.textColor = UIColor.white
          currencyBIncome.sizeToFit()
          
          currencyBIncomeLabel.layer.masksToBounds = true
          currencyBIncomeLabel.layer.cornerRadius = 5
          currencyBIncomeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

          
          
          currencyBExpend.text = String(coinDataSum(coinName: "Ethereum").expandSum)
          currencyBExpend.layer.masksToBounds = true
          currencyBExpend.layer.cornerRadius = 10

          currencyBExpend.layer.backgroundColor =  UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1).cgColor
          currencyBExpend.textColor = UIColor.white
          currencyBExpend.sizeToFit()
          
          currencyBExpendLabel.layer.masksToBounds = true
          currencyBExpendLabel.layer.cornerRadius = 0
          currencyBExpendLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

         
          
          currencyCIncome.text = String(coinDataSum(coinName: "Ripple").incomeSum)
          currencyCIncome.layer.masksToBounds = true
          currencyCIncome.layer.cornerRadius = 10

          currencyCIncome.layer.backgroundColor = UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1).cgColor
          currencyCIncome.textColor = UIColor.white
          currencyCIncome.sizeToFit()
          
          currencyCIncomeLabel.layer.masksToBounds = true
          currencyCIncomeLabel.layer.cornerRadius = 5
          currencyCIncomeLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

          
          
          currencyCExpend.text = String(coinDataSum(coinName: "Ripple").expandSum)
          currencyCExpend.layer.masksToBounds = true
          currencyCExpend.layer.cornerRadius = 10
          currencyCExpend.layer.backgroundColor = UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1).cgColor
          currencyCExpend.textColor = UIColor.white
          currencyCExpendLabel.layer.masksToBounds = true
          currencyCExpend.sizeToFit()
          
          currencyCExpendLabel.layer.cornerRadius = 5
          currencyCExpendLabel.textColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
          
          
          
          bitcoinLabel.layer.masksToBounds = true
          bitcoinLabel.layer.cornerRadius = 5
          bitcoinLabel.layer.backgroundColor = UIColor(red: 0, green: 0.3922, blue: 0, alpha: 1).cgColor
          bitcoinLabel.textColor = UIColor.white
          bitcoinLabel.sizeToFit()
          
          ethereumLabel.layer.masksToBounds = true
          ethereumLabel.layer.cornerRadius = 5
          ethereumLabel.layer.backgroundColor = UIColor(red: 0.8039, green: 0, blue: 0, alpha: 1).cgColor
          ethereumLabel.textColor = UIColor.white
          
          rippleLabel.layer.masksToBounds = true
          rippleLabel.layer.cornerRadius = 5
          rippleLabel.layer.backgroundColor = UIColor(red: 1, green: 0.7255, blue: 0.0588, alpha: 1).cgColor
          rippleLabel.textColor = UIColor.white
          
          

          recentRecordTitle.textColor = UIColor(red: 0.0941, green: 0.4549, blue: 0.8039, alpha: 1)
          
          
          goAnalysis.layer.masksToBounds = true
          goAnalysis.layer.cornerRadius = 5
          goAnalysis.layer.backgroundColor = UIColor(red: 0.0941, green: 0.4549, blue: 0.8039, alpha: 1).cgColor
          goAnalysis.setTitleColor(UIColor.white, for: UIControl.State.normal)
          
          
          retrieveRecentData()    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
