//
//  RecordTableViewCell.swift
//  HUAWEI Wallet
//
//  Created by 刘皇逊 on 23/5/20.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIScreen.main.nativeBounds.height == 1136 {
            amountLabel.font = amountLabel.font.withSize(17) // for others 20
            titleLabel.font = titleLabel.font.withSize(14) // for others 17
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
