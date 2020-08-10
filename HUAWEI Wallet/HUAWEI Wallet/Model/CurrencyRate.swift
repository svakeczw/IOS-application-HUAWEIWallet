//
//  CurrencyRate.swift
//  HUAWEI Wallet
//
//  Created by NIUHUIYUN on 2020/6/4.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

class CurrencyRate {
    var currencyDictionary = [String:Double]()
    
    var myCurrencyList: [String] = ["ETH", "XRP", "USD", "AUD", "EUR", "GBP", "CNY", "JPY", "KRW"]
    
    func getData() {
           let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/BTC?apikey=DBF7F018-C2EF-49FD-A694-4DB12C9610C1")
       
//            let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/BTC?apikey=CF213894-9C50-4F7A-BAF4-67E97494241D")
//          let url = URL(string: "https://rest.coinapi.io/v1/exchangerate/BTC?apikey=024EEED1-2C34-4A2B-AE56-0E21F2BE6D83")
                  
                  let session = URLSession.shared
                  
                  let task = session.dataTask(with: url!) { (data, response, error) in
                      
                      if data != nil {
                          
                          do {
                           let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                              
                              DispatchQueue.main.async {

                               let array = Array<Dictionary<String, Any>>(jsonResponse["rates"] as! Array)
                               
                               for subArray in array {
                                
                                for currency in self.myCurrencyList {
                                    if subArray["asset_id_quote"] as! String == currency {
                                        let rate = subArray["rate"]! as! Double
                                        self.currencyDictionary.updateValue(rate, forKey: currency)
                                    }
                                }
                                
                                }
                                   self.currencyDictionary.updateValue(1.0, forKey: "BTC")
                                                 UserDefaults.standard.set(self.currencyDictionary, forKey: "currencyDictionary")
                                  
                               }

                          } catch {
                              print("error")
                          }
                        
                          
                      }

                  }
                  task.resume()

           }
       
    
}
