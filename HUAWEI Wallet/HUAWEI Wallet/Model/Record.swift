//
//  Record.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 23/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation
import UIKit


struct Record: Codable {
    var id: Int
    var name: String
    var money: Double
    var currency: Currency
    var date: Date
    var direction: Int
    
    // MARK: 判断money正负行不通，只能var direction
    
//    mutating func direction() -> Int {
//        if money >= 0 {
//            return 1
//        }
//        else {
//            return 0
//        }


    func saveIt(Id: Int, Name: String, Money: Double, Currency: Currency, Date: Date, Direction: Int) {

        let recordTesting = Record(id: Id, name: Name, money: Money, currency: Currency, date: Date, direction: Direction)
        //最好不要换成let
        let model: AddRecordModel = Facade.share.model.addRecordModel
        
        model.recordList.append(recordTesting)
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(recordTesting, forKey: "recordSave\(recordTesting.id)")
            userDefaults.synchronize()
        } catch {
            print(error.localizedDescription)
        }
        
    }

    func retrieveIt()  {
        let userDefaults = UserDefaults.standard
        var i = 0
        let model: AddRecordModel = Facade.share.model.addRecordModel
        while i < model.recordList.count{
        do {
            let recordRead = try userDefaults.getObject(forKey: "recordSave\(i+1)", castTo: Record.self)
            print(recordRead)
            //return recordRead
        } catch {
            print(error.localizedDescription)
            //return nil
        }
            i += 1
        }

    }
}
    


//class Record: Codable{
//        var id: Int
//        var name: String
//        var money: Double
//        var date: Date
//
//        init(Id:Int,Name:String,Money:Double,Date:Date) {
//            self.id = Id
//            self.name = Name
//            self.money = Money
//            self.date = Date
//        }
//}

