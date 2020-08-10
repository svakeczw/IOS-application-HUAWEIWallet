//
//  ConverterViewController.swift
//  HUAWEI Wallet
//
//  Created by NIUHUIYUN on 2020/5/30.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var currencyRate = CurrencyRate()
    
    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var pikerOne: UIPickerView!
    @IBOutlet var pikerTwo: UIPickerView!
    @IBAction func exchangeRate(_ sender: UIButton) {
        
        if let myNum = inputTextField.text {
            if isValidNumber(myNum) {
                if let myNum = Double(myNum) {
                    let myResult = myNum * rate2 / rate1
                    outputLabel.text = String(format: "%.3f", myResult)
                }

            } else {
                outputLabel.text = "input is not valid number"
            }

        }
    }
    var currencyDictionary = [String:Double]()
    var currencyDictionarySorted = [(key: String, value: Double)]()
    var codeArray = [String]()
    var rateArray = [Double]()
    
    var currency1: String = ""
    var currency2: String = ""
    var rate1: Double = 0.0
    var rate2: Double = 0.0
    
    override func viewDidLoad() {
       super.viewDidLoad()
        currencyRate.getData()
        if let currencyList: [String:Double] = UserDefaults.standard.dictionary(forKey: "currencyDictionary") as? [String : Double] {
               self.currencyDictionary = currencyList
            if self.currencyDictionary.count > 0 {
                   self.currencyDictionarySorted = currencyDictionary.sorted(by: { $0.value < $1.value })
                   if self.currencyDictionarySorted.count > 0 {
                       currency1 = currencyDictionarySorted[0].key
                       currency2 = currencyDictionarySorted[0].key
                       rate1 = currencyDictionarySorted[0].value
                       rate2 = currencyDictionarySorted[0].value
                   }
                   
            }
        }
        
        self.pikerOne.reloadAllComponents()
        self.pikerTwo.reloadAllComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        if let currencyList: [String:Double] = UserDefaults.standard.dictionary(forKey: "currencyDictionary") as? [String : Double] {
               self.currencyDictionary = currencyList
            if self.currencyDictionary.count > 0 {
                   self.currencyDictionarySorted = currencyDictionary.sorted(by: { $0.value < $1.value })
                   if self.currencyDictionarySorted.count > 0 {
                       currency1 = currencyDictionarySorted[0].key
                       currency2 = currencyDictionarySorted[0].key
                       rate1 = currencyDictionarySorted[0].value
                       rate2 = currencyDictionarySorted[0].value
                   }

            }
        }
//        self.pikerOne.reloadAllComponents()
//        self.pikerTwo.reloadAllComponents()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        currencyRate.getData()
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count: Int = 0
        if pickerView.tag == 1 || pickerView.tag == 2 {
            count = currencyDictionarySorted.count
        }
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var data = ""
        if pickerView.tag == 1 || pickerView.tag == 2 {
            data = currencyDictionarySorted[row].key
        }
        return data
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if currencyDictionarySorted.count > 0 {
            switch pickerView {
                   case pikerOne:
                       currency1 = currencyDictionarySorted[row].key
                       rate1 = currencyDictionarySorted[row].value
                   case pikerTwo:
                       currency2 = currencyDictionarySorted[row].key
                       rate2 = currencyDictionarySorted[row].value
                   default:
                       break
        }
        
       
        }
        
//        print("Currency 1: \(currency1); Currency 2: \(currency2)")
//        print("rate 1: \(rate1); rate 2: \(rate2)")

    }
    
    // Define function for valid number inputs
    func isValidNumber(_ number: String?) -> Bool {
        guard let number = number else {
            return false
        }
        
        if Double(number) != nil {
            return true
        } else {
            return false
        }
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
