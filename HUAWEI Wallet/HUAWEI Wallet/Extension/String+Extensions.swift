//
//  String+Extensions.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 25/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

extension String {
    func getDoubleFromLocal() -> Double {
        var value = 0.0
        let numberFormatter = NumberFormatter()
        let decimalFiltered = self.replacingOccurrences(of: "٫|,", with: ".", options: .regularExpression)
        numberFormatter.locale = Locale(identifier: "EN")
        if let amountValue = numberFormatter.number(from: decimalFiltered) {
            value = amountValue.doubleValue
        }
        return value
    }
}
