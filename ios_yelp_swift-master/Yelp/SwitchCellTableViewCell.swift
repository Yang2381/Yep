//
//  SwitchCellTableViewCell.swift
//  Yelp
//
//  Created by YangSzu Kai on 2017/2/20.
//  Copyright © 2017年 Timothy Lee. All rights reserved.
//

import UIKit

class SwitchCellTableViewCell: UITableViewCell {

    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
