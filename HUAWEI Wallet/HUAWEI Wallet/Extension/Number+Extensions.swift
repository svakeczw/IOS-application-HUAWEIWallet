//
//  Number+Extensions.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 25/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

extension Int {
    func format(formatString: String) -> String {
        return String(format: "%\(formatString)d", self)
    }
}

extension Double {
    func format(formatString: String) -> String {
        return String(format: "%\(formatString)f", self)
    }

    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }

    func recordPresenter(for direction: Int, preciseDecimal: Int = 2, formatting: Bool = true, currency:Currency) -> String {
        var prefix = ""

        if direction == 0 {
            prefix = "-"
        }
        else if direction == 1 {
            prefix = "+"
        } else {
            prefix = ""
        }
        let absValue = abs(self)

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        if formatting {
            return "\(prefix) \(currency.name) \(absValue.format(formatString: ".\(preciseDecimal)"))"
        } else {
            return "\(prefix) \(currency.name) \(formatter.string(from: NSNumber(value: absValue))!)"
        }
    }
}
