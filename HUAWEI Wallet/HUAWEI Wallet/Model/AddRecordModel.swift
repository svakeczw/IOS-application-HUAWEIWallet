//
//  AddRecordModel.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 23/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

// MARK: record容器

class AddRecordModel {
     var id: Int?
     var name: String?
     var money: Double = 0
     var date: Date = Date()
    
     var expenseIndex = 0
     var incomeIndex = 0
     var accountIndex = 0
    
     var index = 0
    
    // MARK: direction 1 or 0 => income or expense
     var direction = 0
    
//    var allRecord:[Record]?
    
    var recordList = [Record]()
    
    var recordListSorted = [Record]()
    
    var recordSection = [[Record]()]
    
    
    
}
