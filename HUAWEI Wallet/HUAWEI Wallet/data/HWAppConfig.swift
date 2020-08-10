//
//  HWAppConfig.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 12/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation

enum HWAppConfig {
    static var isSnapshot: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaults.snapshotKey)
    }
}
