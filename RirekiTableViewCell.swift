//
//  RirekiTableViewCell.swift
//  CanonBallApp
//
//  Created by 池田拓馬 on 2017/08/20.
//  Copyright © 2017年 eglab. All rights reserved.
//

import UIKit

class RirekiTableViewCell: UITableViewCell {

    @IBOutlet var yyyymmdd: UILabel!
    @IBOutlet var hhmm: UILabel!    
    @IBOutlet var rirekiPoint: UILabel!
    @IBOutlet var rirekiBonusName: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
