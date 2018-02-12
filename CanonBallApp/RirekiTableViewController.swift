//
//  RirekiTableViewController.swift
//  CanonBallApp
//
//  Created by 池田拓馬 on 2017/08/20.
//  Copyright © 2017年 eglab. All rights reserved.
//

import UIKit

class RirekiTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet var dispPoint: UILabel!
    @IBOutlet var backIcon: UIBarButtonItem!
    
    var rirekiAray: [RirekiEntity] = []
    
    var myPoint: Int = 0
    
    // 過去の点数を格納
    var rirekiPoint: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.toolbar.barTintColor = UIColor.white
        
        // self.navigationItem.hidesBackButton = true
        
        // ナビゲーションコントローラのタイトルを取得して空文字をつけて強制更新させる
        // self.title = self.title! + ""
        
        self.tableview?.register(UINib(nibName: "RirekiTableViewCell", bundle: nil), forCellReuseIdentifier: "rirekiTableViewCell")
        
        // 自作のオブジェクトはData型に変換しないとUserDefaultsに出し入れできない
        if  let storedData = UserDefaults.standard.object(forKey:Const.Udkey.RIREKI) as? Data {
            // deserializing
            if let convert = NSKeyedUnarchiver.unarchiveObject(with: storedData) as? Array<RirekiEntity> {
                rirekiAray = convert
            }
        }
        
        if UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) != nil {
            myPoint = UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) as! Int
            dispPoint.text = "\(myPoint)"
        }
        
        //レンダリングモードをAlwayOriginalにして画像を読み込む (bar button items はデフォルトで色がついてしまうため)
        let back = UIImage(named: "back.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        backIcon.image = back
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // toolbar を非表示にする
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    /**
     * テーブル設定
     */

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(rirekiAray.isEmpty) {
            return 1
        }else {
            return rirekiAray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rirekiTableViewCell", for: indexPath) as! RirekiTableViewCell
        
        if (rirekiAray.count > 0) {
            
            // 降順にするため、配列の後ろの番地の値からセルにつっこむ
            let order = (rirekiAray.count - indexPath.row) - 1
            let rireki = rirekiAray[order]
            
            cell.yyyymmdd?.text = rireki.yyyymmdd
            cell.hhmm?.text = rireki.hhmm
            
            // マイナス記号が入ると表示がずれてしまうため、プラスのときは記号分の半スペ2個をつっこむ
            if (Int(rireki.rirekiPoint)! >= 0) {
                cell.rirekiPoint?.text = " \(rireki.rirekiPoint)p"
            } else {
                cell.rirekiPoint?.text = "\(rireki.rirekiPoint)p"
                cell.rirekiPoint.textColor = UIColor(red: 87/255.0, green: 155/255.0, blue: 188/255.0, alpha: 1.0)
            }
            
            cell.rirekiBonusName?.text = rireki.rirekiBonusName
            
            // 降順状態の履歴ポイント配列を作成
            rirekiPoint.append(Int(rireki.rirekiPoint)!)
            
        } else {
            // 履歴がないときは何も表示しない
            cell.yyyymmdd?.text = ""
            cell.hhmm?.text = ""
            cell.rirekiPoint?.text = ""
            cell.rirekiBonusName?.text = ""
        }
        
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルのタップイベント
    }
    
    // セルを編集するメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // 削除
        if editingStyle == UITableViewCellEditingStyle.delete {
            let order = (rirekiAray.count - indexPath.row) - 1
            rirekiAray.remove(at: order)
            
            // ここに減点処理を入れる
            var myPoint = UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) as! Int
            myPoint -= rirekiPoint[indexPath.row]
            UserDefaults.standard.set(myPoint, forKey: Const.Udkey.MYPOINT)
            dispPoint.text = "\(myPoint)"
            
            // 配列を削除する
            rirekiPoint.remove(at: indexPath.row)
            
            // serializing
            let archiveData = NSKeyedArchiver.archivedData(withRootObject: rirekiAray)
            UserDefaults.standard.set(archiveData, forKey: Const.Udkey.RIREKI)
            
            tableview.reloadData()
        }
        
    }
    
    

}
