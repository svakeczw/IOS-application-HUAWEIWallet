//
//  Date+extensions.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 23/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

extension Date {
static func randomDate(range: Int) -> Date {
    // Get the interval for the current date
    let interval =  Date().timeIntervalSince1970

    // There are 86,400 milliseconds in a day (ignoring leap dates)
    // Multiply the 86,400 milliseconds against the valid range of days
    let intervalRange = Double(86_400 * range)

    // Select a random point within the interval range
    let random = Double(arc4random_uniform(UInt32(intervalRange)) + 1)

    // Since this can either be in the past or future, we shift the range
    // so that the halfway point is the present
    let newInterval = interval + (random - (intervalRange / 2.0))
    // Initialize a date value with our newly created interval

    return Date(timeIntervalSince1970: newInterval)
}

func dayRepresentation() -> String {
    let calendar = Calendar.current
    if calendar.isDateInToday(self) {
        return "Today"
    } else if calendar.isDateInYesterday(self) {
        return "Yesterday"
    } else if calendar.isDate(Date(), equalTo: self, toGranularity: .weekOfYear) {
        let formatter = DateFormatter()
        let weekday = calendar.component(.weekday, from: self)
        return formatter.weekdaySymbols[weekday-1]
    } else {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
    
    func dateOnly() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        let dateString = dateFormatter.string(from: self)

        return dateFormatter.date(from: dateString)!
    }
}

