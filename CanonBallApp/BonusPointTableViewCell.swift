//
//  BonusPointTableViewCell.swift
//  CanonBallApp
//
//  Created by 池田拓馬 on 2017/08/15.
//  Copyright © 2017年 eglab. All rights reserved.
//

import UIKit

// delegateをOptionalで宣言したいので、protocolには: class`または`@objc`が必要
protocol Calk: class {
    func setPoint()
    func setAlert(getPt: Int)
    func getBPName(cell: BonusPointTableViewCell)
}

class BonusPointTableViewCell: UITableViewCell {

    @IBOutlet weak var pointImg: UIImageView!
    @IBOutlet weak var pointName: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    // delegate は必ずweak
    // nilになる可能性は常にあるので明示的にOptionalにする
    weak var delegate: Calk?
    
    let gradientLayer = CAGradientLayer()
    
    @IBAction func AddBtn(_ btn: UIButton) {

        let getPoint = Int(btn.tag)
        
        let cell = btn.superview?.superview as! BonusPointTableViewCell
        
        self.delegate?.getBPName(cell: cell)
        
        // 明示的Optionalなので、Optional Chainingを使う
        self.delegate?.setAlert(getPt: getPoint)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
