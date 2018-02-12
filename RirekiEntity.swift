//
//  RirekiEntity.swift
//  CanonBallApp
//
//  Created by 池田拓馬 on 2017/08/20.
//  Copyright © 2017年 eglab. All rights reserved.
//

import Foundation

class RirekiEntity :NSObject, NSCoding {

    var yyyymmdd: String = ""
    var hhmm: String = ""
    var rirekiPoint: String = ""
    var rirekiBonusName: String = ""
    
    init(yyyymmdd :String, hhmm: String, rirekiPoint: String = "", rirekiBonusName: String = "") {
        self.yyyymmdd = yyyymmdd
        self.hhmm = hhmm
        self.rirekiPoint = rirekiPoint
        self.rirekiBonusName = rirekiBonusName
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(yyyymmdd, forKey: "yyyymmdd")
        aCoder.encode(hhmm, forKey: "hhmm")
        aCoder.encode(rirekiPoint, forKey: "rirekiPoint")
        aCoder.encode(rirekiBonusName, forKey: "rirekiBonusName")
    }
    
    required init?(coder aDecoder: NSCoder) {
        yyyymmdd = aDecoder.decodeObject(forKey: "yyyymmdd") as! String
        hhmm = aDecoder.decodeObject(forKey: "hhmm") as! String
        rirekiPoint = aDecoder.decodeObject(forKey: "rirekiPoint") as! String
        rirekiBonusName = aDecoder.decodeObject(forKey: "rirekiBonusName") as! String
    }
    
}
