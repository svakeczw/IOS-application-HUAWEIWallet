//
//  CurrencyTableViewCell.swift
//  HUAWEI Wallet
//
//  Created by NIUHUIYUN on 2020/5/29.
//  Copyright © 2020 hayden. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyType: UILabel!
    @IBOutlet var currencyRate: UILabel!
    @IBOutlet var currencyImage: UIImageView!
    
    let cellView: UIView = {
           let view = UIView(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 80))
           view.layer.cornerRadius  = 40
           view.backgroundColor     = UIColor.lightGray
           view.layer.shadowColor   = UIColor.black.cgColor
           view.layer.shadowOpacity = 1
           view.layer.shadowOffset  = CGSize.zero
           view.layer.shadowRadius  = 1
           return view
       }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(cellView)
        sendSubviewToBack(cellView)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
