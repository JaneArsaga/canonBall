//
//  TopTableViewController.swift
//  CanonBallApp
//
//  Created by 池田拓馬 on 2017/08/15.
//  Copyright © 2017年 eglab. All rights reserved.
//

import UIKit

class TopTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Calk {
    
    // @IBOutlet var tableview: UITableView!
    @IBOutlet var tableview: UITableView!
    
    // @IBOutlet var dispPoint: UILabel!
    @IBOutlet var dispPoint: UILabel!
    
    @IBOutlet var deleteIcon: UIBarButtonItem!
    @IBOutlet var penIcon: UIBarButtonItem!
    @IBOutlet var rirekiIcon: UIBarButtonItem!
    
    var myPoint: Int = 0
    var getPoint: Int = 0
    
    // @IBOutlet var pointView: UIView!
    @IBOutlet var pointView: UIView!
    
    private var myUIPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.toolbar.barTintColor = UIColor.clear

        //タイトル取得して空文字をつけることによって強制更新させる
        self.title = self.title! + ""
        
        self.tableview?.register(UINib(nibName: "BonusPointTableViewCell", bundle: nil), forCellReuseIdentifier: "bonusPointCell")
        
        if UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) != nil {
            myPoint = UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) as! Int
            dispPoint.text = "\(myPoint)"
        }
        
        //レンダリングモードをAlwayOriginalにして画像を読み込む (bar button items はデフォルトで色がついてしまうため)
        let delete = UIImage(named: "delete.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let pen = UIImage(named: "pen.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let rireki = UIImage(named: "rireki.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        deleteIcon.image = delete
        penIcon.image = pen
        rirekiIcon.image = rireki
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 過去の点数の準備
        if UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) != nil {
            myPoint = UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) as! Int
            dispPoint.text = "\(myPoint)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigationController の toolbar は毎回セットしておかないと Back ボタンで戻ったときに消えてしまう
        self.navigationController?.setToolbarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
     セクション数を返却する
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return Const.SectionConst.mySections.count
    }
    
    /*
     セクション名を返却する
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Const.SectionConst.mySections[section] as? String
    }
    
    /*
     セクション毎にセル数を返却する
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Const.RaceInfo.raceName.count
        case 1:
            return Const.BonusInfo.bonusName.count
        default:
            return 0
        }
    }
    
    /*
     セクションのデザインを設定する
     */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 文字の設定
        let label : UILabel = UILabel()
        let sectionView = UIView()
        
        label.textColor = UIColor.darkGray
        label.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        label.font = UIFont(name: "Thonburi-Bold", size: 15)
        label.textAlignment = .center
        
        if(section == 0){
            label.text = Const.SectionConst.mySections[section] as? String
            
            let sectionImage = UIImage(named: "car.png")
            let sectionImageView = UIImageView(image: sectionImage)
            sectionImageView.frame = CGRect(x:0.0, y:0.0, width:30.0, height:30.0)
            sectionView.addSubview(sectionImageView)

        } else if (section == 1){
            label.text = Const.SectionConst.mySections[section] as? String
            
            let sectionImage = UIImage(named: "money.png")
            let sectionImageView = UIImageView(image: sectionImage)
            sectionImageView.frame = CGRect(x:0.0, y:0.0, width:30.0, height:30.0)
            sectionView.addSubview(sectionImageView)

        }
        return label
    }
    
    /*
     セルの高さ
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    /*
     セルの作成
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bonusPointCell", for: indexPath) as! BonusPointTableViewCell
        
        // 現在表示を担当しているTableViewインスタンスを`delegate`に設定する
        cell.delegate = self
        
        // セルを透明に設定
        cell.backgroundColor = UIColor.clear
        
        /**
         グラデーション作成
         */
        
        let gradient = CAGradientLayer()
        let gradientLocations = [0.0, 1.0]
        // gradient.frame = view.bounds;
        gradient.frame = view.frame;
        
        gradient.colors = [UIColor(red: 208/255.0, green: 0/255.0, blue: 127/255.0, alpha: 1.0).cgColor,
                           UIColor(red: 46/255.0, green: 167/255.0, blue: 224/255.0, alpha: 1.0).cgColor
        ]
        
        gradient.locations = gradientLocations as [NSNumber]?
        
        // boundsは自分の座標 (transform前)
        // let backgroundView = UIView(frame: view.bounds)
        
        // frameは親からの座標 (transform後)
        let backgroundView = UIView(frame: view.frame)
        
        backgroundView.layer.insertSublayer(gradient, at: 0)
        tableview.backgroundView = backgroundView

        // 罫線: 白
        tableview.separatorColor = UIColor.white
        // tableview.backgroundColor = UIColor.clear

        // レース順位のセル作成
        if indexPath.section == 0 {
            // セルにポイント名を表示
            cell.pointName?.text = Const.RaceInfo.raceName[indexPath.row][0]
            
            // セルにポイント画像を表示
            getImg(i: Int(Const.RaceInfo.raceName[indexPath.row][1])!, c: cell)
            
            // セル内のボタンのタグに点数を埋め込んでおく
            cell.addBtn.tag = Int(Const.RaceInfo.raceName[indexPath.row][1])!
        }
        
        // ボーナスポイントのセル作成
        if indexPath.section == 1 {
            // セルにポイント名を表示
            cell.pointName?.text = Const.BonusInfo.bonusName[indexPath.row][0]
            
            // セルにポイント画像を表示
            getImg(i: Int(Const.BonusInfo.bonusName[indexPath.row][1])!, c: cell)
            
            // セル内のボタンのタグに点数を埋め込んでおく
            cell.addBtn.tag = Int(Const.BonusInfo.bonusName[indexPath.row][1])!
        }
        return cell
    }
    
    /*
     セルのタップで説明表示
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableview.deselectRow(at: indexPath as IndexPath, animated: true)
        
        var message: String = ""
        var title: String = ""
        
        if indexPath.section == 0 {
            message = setMessage(mCode: Const.RaceInfo.raceName[indexPath.row][2])
            title = Const.RaceInfo.raceName[indexPath.row][0]
        } else if indexPath.section == 1 {
            message = setMessage(mCode: Const.BonusInfo.bonusName[indexPath.row][2])
            title = Const.BonusInfo.bonusName[indexPath.row][0]
        }
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    

    /*
     セルに埋め込む点数の画像を取得
     */
    func getImg(i: Int, c: BonusPointTableViewCell) {
        switch i {
        case 10:
            c.pointImg.image = UIImage(named: "10pt.png")
        case 9:
            c.pointImg.image = UIImage(named: "9pt.png")
        case 8:
            c.pointImg.image = UIImage(named: "8pt.png")
        case 7:
            c.pointImg.image = UIImage(named: "7pt.png")
        case 6:
            c.pointImg.image = UIImage(named: "6pt.png")
        case 5:
            c.pointImg.image = UIImage(named: "5pt.png")
        case 4:
            c.pointImg.image = UIImage(named: "4pt.png")
        case 3:
            c.pointImg.image = UIImage(named: "3pt.png")
        case 2:
            c.pointImg.image = UIImage(named: "2pt.png")
        case 1:
            c.pointImg.image = UIImage(named: "1pt.png")
        case 0:
            c.pointImg.image = UIImage(named: "0pt.png")
        case -1:
            c.pointImg.image = UIImage(named: "m1pt.png")
        case -2:
            c.pointImg.image = UIImage(named: "m2pt.png")
        case -3:
            c.pointImg.image = UIImage(named: "m3pt.png")
        case -4:
            c.pointImg.image = UIImage(named: "m4pt.png")
        case -5:
            c.pointImg.image = UIImage(named: "m5pt.png")
        case -6:
            c.pointImg.image = UIImage(named: "m6pt.png")
        case -7:
            c.pointImg.image = UIImage(named: "m7pt.png")
        case -8:
            c.pointImg.image = UIImage(named: "m8pt.png")
        case -9:
            c.pointImg.image = UIImage(named: "m9pt.png")
        case -10:
            c.pointImg.image = UIImage(named: "m10pt.png")
        default:
            c.pointImg.image = UIImage(named: "unknownPt.png")
        }
    }
    
    /*
     コードに紐づいた詳細メッセージを返却
     */
    func setMessage(mCode: String) -> String {
        
        switch mCode {
            // レースネームに紐づく詳細メッセージ
            case Const.RaceNameCode.RN00:
                return Const.PointInfo.RN00
            case Const.RaceNameCode.RN01:
                return Const.PointInfo.RN01
            case Const.RaceNameCode.RN02:
                return Const.PointInfo.RN02
            case Const.RaceNameCode.RN03:
                return Const.PointInfo.RN03
            // ボーナスネームに紐づく詳細メッセージ
            case Const.BonusNameCode.BN00:
                return Const.PointInfo.BN00
            case Const.BonusNameCode.BN01:
                return Const.PointInfo.BN01
            case Const.BonusNameCode.BN02:
                return Const.PointInfo.BN02
            case Const.BonusNameCode.BN03:
                return Const.PointInfo.BN03
            case Const.BonusNameCode.BN04:
                return Const.PointInfo.BN04
            case Const.BonusNameCode.BN05:
                return Const.PointInfo.BN05
            case Const.BonusNameCode.BN06:
                return Const.PointInfo.BN06
            case Const.BonusNameCode.BN07:
                return Const.PointInfo.BN07
            case Const.BonusNameCode.BN08:
                return Const.PointInfo.BN08
            case Const.BonusNameCode.BN09:
                return Const.PointInfo.BN09
            case Const.BonusNameCode.BN10:
                return Const.PointInfo.BN10
            case Const.BonusNameCode.BN11:
                return Const.PointInfo.BN11
            case Const.BonusNameCode.BN12:
                return Const.PointInfo.BN12
            case Const.BonusNameCode.BN13:
                return Const.PointInfo.BN13
            case Const.BonusNameCode.BN14:
                return Const.PointInfo.BN14
            case Const.BonusNameCode.BN15:
                return Const.PointInfo.BN15
            case Const.BonusNameCode.BN16:
                return Const.PointInfo.BN16
            case Const.BonusNameCode.BN17:
                return Const.PointInfo.BN17
            case Const.BonusNameCode.BN18:
                return Const.PointInfo.BN18
            case Const.BonusNameCode.BN19:
                return Const.PointInfo.BN19
            case Const.BonusNameCode.BN20:
                return Const.PointInfo.BN20
            case Const.BonusNameCode.BN21:
                return Const.PointInfo.BN21
            case Const.BonusNameCode.BN22:
                return Const.PointInfo.BN22
            case Const.BonusNameCode.BN23:
                return Const.PointInfo.BN23
            // 存在しないコード
            default:
                return Const.PointInfo.BN99
        }
    }
    
    // delegateメソッド
    func setAlert(getPt: Int) {
        
        let BPName = UserDefaults.standard.object(forKey:Const.Udkey.BPNAME) as! String
        let message = "\(BPName) ★ \(getPt)ポイント"
        
        // アラートを作成
        let alert = UIAlertController(
            title: Const.Message.addMsgTitle,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Const.Message.addOk,
                                      style: .default,
                                      handler: { action in
                                            UserDefaults.standard.set(getPt, forKey: Const.Udkey.GETPOINT)
                                            self.setPoint()
        }))
        
        alert.addAction(UIAlertAction(title: Const.Message.addCancel, style: .cancel))
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    
    // delegateメソッド
    func setPoint() {
        
        getPoint = UserDefaults.standard.object(forKey:Const.Udkey.GETPOINT) as! Int
        
        if UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) != nil {
            myPoint = UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) as! Int
        }
        
        myPoint += getPoint
        UserDefaults.standard.set(myPoint, forKey: Const.Udkey.MYPOINT)
        dispPoint.text = "\(myPoint)"
        
        let yyyymmdd = getYyyymmdd()
        let hhmm = getHhmm()
        let rirekiPoint = String(getPoint)
        let rirekiBonusName = UserDefaults.standard.object(forKey:Const.Udkey.BPNAME) as! String

        //  履歴を作成する
        let newRireki = RirekiEntity(yyyymmdd: yyyymmdd, hhmm: hhmm, rirekiPoint: rirekiPoint, rirekiBonusName: rirekiBonusName)
        
        var rirekiAray : Array<RirekiEntity> = []
        
        // 自作のオブジェクトはData型に変換しないとUserDefaultsに出し入れできない
        if  let storedData = UserDefaults.standard.object(forKey:Const.Udkey.RIREKI) as? Data {
            // deserializing
            if let convert = NSKeyedUnarchiver.unarchiveObject(with: storedData) as? Array<RirekiEntity> {
                rirekiAray = convert
            }
        }
        
        rirekiAray.append(newRireki)
        
        // serializing
        let archiveData = NSKeyedArchiver.archivedData(withRootObject: rirekiAray)
        UserDefaults.standard.set(archiveData, forKey: Const.Udkey.RIREKI)
    }
    
    /*
     タップしたセルのセクションと場所から、そこのポイントを取得して設定する
     */
    func getBPName(cell: BonusPointTableViewCell) {
        let row = tableview.indexPath(for: cell)?.row
        if tableview.indexPath(for: cell)?.section == 0 {
            // 便宜上レースポイントもボーナスポイント(BPName)として登録している
            UserDefaults.standard.set(Const.RaceInfo.raceName[row!][0], forKey: Const.Udkey.BPNAME)
        } else if tableview.indexPath(for: cell)?.section == 1 {
            UserDefaults.standard.set(Const.BonusInfo.bonusName[row!][0], forKey: Const.Udkey.BPNAME)
        }
    }
    
    /*
     初期化ボタンタップ時のアクション
     */
    @IBAction func reset(_ sender: Any) {
        
        let message = Const.Message.deleteMsg
        
        // アラートを作成
        let alert = UIAlertController(
            title: Const.Message.deleteMsgTitle,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Const.Message.ok01,
                                      style: .default,
                                      handler: { action in
            self.confirmReset()
                                        
        }))
        
        alert.addAction(UIAlertAction(title: Const.Message.cancel01, style: .cancel))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)

    }
    
    /*
     初期化確認メッセージを表示、実行
     */
    func confirmReset() {
        let message = Const.Message.confirmDeleteMsg
        
        // アラートを作成
        let alert = UIAlertController(
            title: Const.Message.confirmDeleteMsgTitle,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: Const.Message.ok02,
                                      style: .default,
                                      handler: { action in
                                        UserDefaults.standard.set(0, forKey: Const.Udkey.MYPOINT)
                                        UserDefaults.standard.set(0, forKey: Const.Udkey.GETPOINT)
                                        self.myPoint = 0
                                        self.getPoint = 0
                                        self.dispPoint.text = "\(self.myPoint)"
                                        
                                        let rirekiAray : Array<RirekiEntity> = []
                                        // serializing
                                        let archiveData = NSKeyedArchiver.archivedData(withRootObject: rirekiAray)
                                        UserDefaults.standard.set(archiveData, forKey: Const.Udkey.RIREKI)
                                        
        }))
        
        alert.addAction(UIAlertAction(title: Const.Message.cancel02, style: .cancel))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     日付を文字列で作成
     */
    func getYyyymmdd(format:String = "yyyy.MM.dd") -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    /*
     時間を文字列で作成
     */
    func getHhmm(format:String = "HH:mm") -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    /*
     ポイント調整ボタンタップ時のアクション
     */
    @IBAction func adjustPoint(_ sender: Any) {
        showAdustAlert()
    }
    
    /*
     ポイント調整メッセージ表示、計算
     */
    func showAdustAlert() {
        let alert = UIAlertController(title: Const.Message.adjustMsgTitle, message: "", preferredStyle: .alert)
        // ポイントプラス
        let plusAction = UIAlertAction(title: Const.Message.plus, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            var rirekiExeFlg = false
            
            let yyyymmdd = self.getYyyymmdd()
            let hhmm = self.getHhmm()
            var rirekiPoint = ""
            var rirekiBonusName = Const.Message.plusInfoMsg
            
            var rirekiAray : Array<RirekiEntity> = []
            
            // 自作のオブジェクトはData型に変換しないとUserDefaultsに出し入れできない
            if  let storedData = UserDefaults.standard.object(forKey:Const.Udkey.RIREKI) as? Data {
                // deserializing
                if let convert = NSKeyedUnarchiver.unarchiveObject(with: storedData) as? Array<RirekiEntity> {
                    rirekiAray = convert
                }
            }
            
            if let textFields = alert.textFields {
                // textFieldsにはアラートの全ての値が入っている
                var i = 0
                
                for textField in textFields {
                    // ポイントのテキスト
                    if i == 0 {
                        if let point = Int(textField.text!) {
                            if point > 10 || point < 1 {
                                return
                            } else {
                                // 登録
                                rirekiExeFlg = true
                                rirekiPoint = String(point)
                            }
                        }
                    
                        i += 1
                    }
                    
                    // 理由のテキスト
                    if i == 1 {
                        rirekiBonusName = textField.text!
                        i = 0
                    }
                }
            }
            
            if rirekiExeFlg {
                //  履歴を作成する
                let newRireki = RirekiEntity(yyyymmdd: yyyymmdd, hhmm: hhmm, rirekiPoint: rirekiPoint, rirekiBonusName: rirekiBonusName)
                rirekiAray.append(newRireki)
                
                // serializing
                let archiveData = NSKeyedArchiver.archivedData(withRootObject: rirekiAray)
                UserDefaults.standard.set(archiveData, forKey: Const.Udkey.RIREKI)
                
                rirekiExeFlg = false
                
                if UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) != nil {
                    self.myPoint = UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) as! Int
                }
                
                self.myPoint += Int(rirekiPoint)!
                
                UserDefaults.standard.set(self.myPoint, forKey: Const.Udkey.MYPOINT)
                UserDefaults.standard.set(Int(rirekiPoint)!, forKey: Const.Udkey.GETPOINT)
                self.dispPoint.text = "\(self.myPoint)"
            }
            
        })
        alert.addAction(plusAction)

        // ポイントマイナス
        let minusAction = UIAlertAction(title: Const.Message.minus, style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            var rirekiExeFlg = false
            
            let yyyymmdd = self.getYyyymmdd()
            let hhmm = self.getHhmm()
            var rirekiPoint = ""
            var rirekiBonusName = Const.Message.minusInfoMsg
            
            var rirekiAray : Array<RirekiEntity> = []
            
            // 自作のオブジェクトはData型に変換しないとUserDefaultsに出し入れできない
            if  let storedData = UserDefaults.standard.object(forKey:Const.Udkey.RIREKI) as? Data {
                // deserializing
                if let convert = NSKeyedUnarchiver.unarchiveObject(with: storedData) as? Array<RirekiEntity> {
                    rirekiAray = convert
                }
            }
            
            if let textFields = alert.textFields {
                // textFieldsにはアラートの全ての値が入っている
                var i = 0
                
                for textField in textFields {
                    // ポイントのテキスト
                    if i == 0 {
                        if let point = Int(textField.text!) {
                            if point > 10 || point < 1 {
                                return
                            } else {
                                // 登録
                                rirekiExeFlg = true
                                rirekiPoint = "-" + String(point)
                            }
                        }
                        
                        i += 1
                    }
                    
                    // 理由のテキスト
                    if i == 1 {
                        rirekiBonusName = textField.text!
                        i = 0
                    }
                }
            }
            
            if rirekiExeFlg {
                //  履歴を作成する
                let newRireki = RirekiEntity(yyyymmdd: yyyymmdd, hhmm: hhmm, rirekiPoint: rirekiPoint, rirekiBonusName: rirekiBonusName)
                rirekiAray.append(newRireki)
                
                // serializing
                let archiveData = NSKeyedArchiver.archivedData(withRootObject: rirekiAray)
                UserDefaults.standard.set(archiveData, forKey: Const.Udkey.RIREKI)
                rirekiExeFlg = false
                
                if UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) != nil {
                    self.myPoint = UserDefaults.standard.object(forKey:Const.Udkey.MYPOINT) as! Int
                }
                
                self.myPoint += Int(rirekiPoint)!
                
                UserDefaults.standard.set(self.myPoint, forKey: Const.Udkey.MYPOINT)
                UserDefaults.standard.set(Int(rirekiPoint)!, forKey: Const.Udkey.GETPOINT)
                self.dispPoint.text = "\(self.myPoint)"

                
            }
            
        })
        alert.addAction(minusAction)
        
        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: Const.Message.adjustCancel, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(point: UITextField!) -> Void in
            point.placeholder = Const.Message.adjustMsg
            point.keyboardType = UIKeyboardType.numberPad
            // 初期フォーカス
            point.becomeFirstResponder()
        })
        
        alert.addTextField(configurationHandler: {(reason: UITextField!) -> Void in
            reason.placeholder = Const.Message.reasonMsg
        })
        
        alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
        
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /*
     戻るボタンタップ時のアクション
    */
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
}

