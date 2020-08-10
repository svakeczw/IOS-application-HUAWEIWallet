//
//  currency.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 23/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation
import UIKit

//市值排名第一 BTC比特币 Bitcoin
//市值排名第二 ETH以太坊 Ethereum
//市值排名第三 XRP瑞波币 Ripple
//...

struct Currency: Codable {
    var id: Int
    var name: String
    var rate: Double
    var icon: String
}

var currency_1 = Currency(id: 1, name: "Bitcoin", rate: 1.0, icon: "bitcoinsign.circle.fill")
var currency_2 = Currency(id: 2, name: "Ethereum", rate: 2.0, icon: "ant.circle.fill")
var currency_3 = Currency(id: 3, name: "Ripple", rate: 3.0, icon: "australsign.circle.fill")
var defaultCurrency = Currency(id: 1, name: "Bitcoin", rate: 1.0, icon: "bitcoinsign.circle.fill")


