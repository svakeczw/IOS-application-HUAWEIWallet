//
//  Facade.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 12/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

class Facade {
    static let share = Facade()
    let model = PersistentModel()

    private init() {
//        print("Facade - init")
    }
}

