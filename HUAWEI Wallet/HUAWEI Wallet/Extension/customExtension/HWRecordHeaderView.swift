//
//  HWRecordHeaderView.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 25/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import Foundation
import UIKit

struct HWRecordHeaderViewModel {
    let title: String?
    let spending: String?
}

class HWRecordHeaderView: HWCustomView {
    
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet var spendingLabel: UILabel?
    
    override func initUI() {
        self.titleLabel?.font = self.titleLabel?.font.withSize(17)
        self.spendingLabel?.font = self.spendingLabel?.font.withSize(15)
        self.spendingLabel?.textColor = .gray
    }

    func setup(with viewModel: HWRecordHeaderViewModel) {
        self.titleLabel?.text = viewModel.title
        self.spendingLabel?.text = viewModel.spending
    }
    func newsetup(with viewModel: HWRecordHeaderViewModel) {
        self.titleLabel?.text = viewModel.title
        self.spendingLabel?.text = ""
    }
    
}
