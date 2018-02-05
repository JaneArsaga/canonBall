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
    
    private let pickerValues = [-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    // Sectionで使用する配列を定義する.
    private let mySections: NSArray = ["レ ー ス ポ イ ン ト", "貧 乏 ポ イ ン ト"]
    
    /*
     自前のBonus型を宣言して、bonusNameを[Bonus]型にしてしまえば、意味のわかりにくい[0] [1] [2]など使わなくて済む
     */
    
    let raceName: [[String]] = [
        ["レース1着", "10", "RN00"],
        ["レース2着", "5", "RN01"],
        ["レース3着", "1", "RN02"],
        ["どぼん", "-5", "RN03"]
    ]
    
    // ボーナスポイント名、ボーナスポイント、メッセージコード(mCode)
    let bonusName: [[String]] = [
        ["残金一番多い", "8", "BN00"],
        ["人ん家", "3", "BN01"],
        ["わらしべ長者", "3", "BN02"],
        ["夜のタダメシ", "3", "BN03"],
        ["タダメシ", "2", "BN04"],
        ["観光案内", "2", "BN05"],
        ["1番", "1", "BN06"],
        ["稼ぐ", "1", "BN07"],
        ["記念撮影", "1", "BN08"],
        ["名物 / 名所", "1", "BN09"],
        ["なんか物もらう", "1", "BN10"],
        ["10代", "1", "BN11"],
        ["LINE交換", "1", "BN12"],
        ["あたたかい布団", "1", "BN13"],
        ["残金1桁", "1", "BN14"],
        ["嘘", "-1", "BN15"],
        ["メシ抜き", "-1", "BN16"],
        ["風呂なし", "-1", "BN17"],
        ["おごる", "-2", "BN18"],
        ["しばかれる", "-2", "BN19"],
        ["職務質問", "-3", "BN20"],
        ["交通違反", "-5", "BN21"],
        ["どぼん(残金マイナス)", "-5", "BN22"],
        ["どぼん(時間切れ)", "-5", "BN23"],
    ]
    
    let RN00 = "1着"
    let RN01 = "2着"
    let RN02 = "3着"
    let RN03 = "どぼん"
    
    let BN00 = "あ"
    let BN01 = "い"
    let BN02 = "う"
    let BN03 = "え"
    let BN04 = "お"
    let BN05 = "か"
    let BN06 = "き"
    let BN07 = "く"
    let BN08 = "け"
    let BN09 = "こ"
    let BN10 = "さ"
    let BN11 = "し"
    let BN12 = "す"
    let BN13 = "せ"
    let BN14 = "そ"
    let BN15 = "た"
    let BN16 = "ち"
    let BN17 = "つ"
    let BN18 = "て"
    let BN19 = "と"
    let BN20 = "な"
    let BN21 = "に"
    let BN22 = "ぬ"
    let BN23 = "ね"
    let BN99 = "存在しないボーナス名です"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.toolbar.barTintColor = UIColor.clear

        //タイトル取得して空文字をつけることによって強制更新させる
        self.title = self.title! + ""
        
        self.tableview?.register(UINib(nibName: "BonusPointTableViewCell", bundle: nil), forCellReuseIdentifier: "bonusPointCell")
        
        if UserDefaults.standard.object(forKey:"myPoint") != nil {
            myPoint = UserDefaults.standard.object(forKey:"myPoint") as! Int
            dispPoint.text = "\(myPoint)"
        }
        
        //レンダリングモードをAlwayOriginalにして画像を読み込む (bar button items はデフォルトで色(tint)がついてしまうため)
        let delete = UIImage(named: "delete.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let pen = UIImage(named: "pen.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let rireki = UIImage(named: "rireki.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        deleteIcon.image = delete
        penIcon.image = pen
        rirekiIcon.image = rireki
        
    }
    
    // 表示後になんとかするメソッド
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // 表示前になんとかするメソッド
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigationController の toolbar は毎回セットしておかないと Back ボタンで戻ったときに消えてしまう
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        // 過去の点数の準備
        if UserDefaults.standard.object(forKey:"myPoint") != nil {
            myPoint = UserDefaults.standard.object(forKey:"myPoint") as! Int
            dispPoint.text = "\(myPoint)"
        }
        
        /**
         *  テーブルビューのバウンド演出
         */
        
//        tableview.bounces = false
//        tableview.alwaysBounceVertical = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    /**
     * テーブル設定
     */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    
    // section のタイトルを返す
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mySections[section] as? String
    }
    
    // section 名の配列を返す
//    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
//        return mySections as? [String]
//    }

    // section 毎のセル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return raceName.count
        case 1:
            return bonusName.count
        default:
            return 0
        }
    }
    
    //この関数内で section の見た目の設定を行う
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label : UILabel = UILabel()
        let sectionView = UIView()
        
        // section 文字(label)の設定
        label.textColor = UIColor.darkGray
        // section　すべて白くする
        label.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
        label.font = UIFont(name: "Thonburi-Bold", size: 15)
        label.textAlignment = .center
        
        if(section == 0){
            label.text = mySections[section] as? String
            // section に画像を埋め込む
            let sectionImage = UIImage(named: "car.png")
            let sectionImageView = UIImageView(image: sectionImage)
            sectionImageView.frame = CGRect(x:0.0, y:0.0, width:30.0, height:30.0)
            sectionView.addSubview(sectionImageView)
            // section すべて白くする
            sectionView.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)
            

        } else if (section == 1){
            label.text = mySections[section] as? String
            // section に画像を埋め込む
            let sectionImage = UIImage(named: "money.png")
            let sectionImageView = UIImageView(image: sectionImage)
            sectionImageView.frame = CGRect(x:0.0, y:0.0, width:30.0, height:30.0)
            sectionView.addSubview(sectionImageView)
            // section すべて白くする
            sectionView.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1.0)

        }
        
        
//        label.addSubview(sectionView)
//        label.bringSubview(toFront: sectionView)
        
        return label
        
        // なぜか label が追加されない
        // sectionView.addSubview(label)

        // return sectionView
        
    }
    
    
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
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
        
        /**
         View作成 → グラデーション適用
         */
        
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
            cell.pointName?.text = raceName[indexPath.row][0]
            
            // セルにポイント画像を表示
            getImg(i: Int(raceName[indexPath.row][1])!, c: cell)
            
            // セル内のボタンのタグに点数を埋め込んでおく
            cell.addBtn.tag = Int(raceName[indexPath.row][1])!
        }
        
        // ボーナスポイントのセル作成
        if indexPath.section == 1 {
            // セルにポイント名を表示
            cell.pointName?.text = bonusName[indexPath.row][0]
            
            // セルにポイント画像を表示
            getImg(i: Int(bonusName[indexPath.row][1])!, c: cell)
            
            // セル内のボタンのタグに点数を埋め込んでおく
            cell.addBtn.tag = Int(bonusName[indexPath.row][1])!

            
        }
        
        return cell
    }
    
    // セルタップで説明表示
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // セル選択時の選択色をなくす
        tableview.deselectRow(at: indexPath as IndexPath, animated: true)
        
        var message: String = ""
        var title: String = ""
        
        if indexPath.section == 0 {
            message = setMessage(mCode: raceName[indexPath.row][2])
            title = raceName[indexPath.row][0]
        } else if indexPath.section == 1 {
            message = setMessage(mCode: bonusName[indexPath.row][2])
            title = bonusName[indexPath.row][0]
        }
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    

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
    
    func setMessage(mCode: String) -> String {
        
        switch mCode {
            
        case "RN00":
            return RN00
        case "RN01":
            return RN01
        case "RN02":
            return RN02
        case "RN03":
            return RN03
            
        case "BN00":
            return BN00
        case "BN01":
            return BN01
        case "BN02":
            return BN02
        case "BN03":
            return BN03
        case "BN04":
            return BN04
        case "BN05":
            return BN05
        case "BN06":
            return BN06
        case "BN07":
            return BN07
        case "BN08":
            return BN08
        case "BN09":
            return BN09
        case "BN10":
            return BN10
        case "BN11":
            return BN11
        case "BN12":
            return BN12
        case "BN13":
            return BN13
        case "BN14":
            return BN14
        case "BN15":
            return BN15
        case "BN16":
            return BN16
        case "BN17":
            return BN17
        case "BN18":
            return BN18
        case "BN19":
            return BN19
        case "BN20":
            return BN20
        case "BN21":
            return BN21
        case "BN22":
            return BN22
        case "BN23":
            return BN23
        default:
            return BN99
        }
    }
    
    // delegateメソッド
    func setAlert(getPt: Int) {
        
        let BPName = UserDefaults.standard.object(forKey:"BPName") as! String
        let message = "\(BPName) ★ \(getPt)ポイント"
        
        // アラートを作成
        let alert = UIAlertController(
            title: "ポイント追加",
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "追加する",
                                      style: .default,
                                      handler: { action in
                                            UserDefaults.standard.set(getPt, forKey: "getPoint")
                                            self.setPoint()
        }))
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    
    // delegateメソッド
    func setPoint() {
        
        getPoint = UserDefaults.standard.object(forKey:"getPoint") as! Int
        
        if UserDefaults.standard.object(forKey:"myPoint") != nil {
            myPoint = UserDefaults.standard.object(forKey:"myPoint") as! Int
        }
        
        myPoint += getPoint
        UserDefaults.standard.set(myPoint, forKey: "myPoint")
        dispPoint.text = "\(myPoint)"
        
        let yyyymmdd = getYyyymmdd()
        let hhmm = getHhmm()
        let rirekiPoint = String(getPoint)
        let rirekiBonusName = UserDefaults.standard.object(forKey:"BPName") as! String

        //  履歴を作成する
        let newRireki = RirekiEntity(yyyymmdd: yyyymmdd, hhmm: hhmm, rirekiPoint: rirekiPoint, rirekiBonusName: rirekiBonusName)
        
        var rirekiAray : Array<RirekiEntity> = []
        
        // 自作のオブジェクトはData型に変換しないとUserDefaultsに出し入れできない
        if  let storedData = UserDefaults.standard.object(forKey:"rireki") as? Data {
            // deserializing
            if let convert = NSKeyedUnarchiver.unarchiveObject(with: storedData) as? Array<RirekiEntity> {
                rirekiAray = convert
            }
        }
        
        rirekiAray.append(newRireki)
        
        // serializing
        let archiveData = NSKeyedArchiver.archivedData(withRootObject: rirekiAray)
        UserDefaults.standard.set(archiveData, forKey: "rireki")
        
    }
    
    func getBPName(cell: BonusPointTableViewCell) {
        let row = tableview.indexPath(for: cell)?.row
        
        if tableview.indexPath(for: cell)?.section == 0 {
            // 便宜上レースポイントもボーナスポイント(BPName)として登録している
            UserDefaults.standard.set(raceName[row!][0], forKey: "BPName")
        } else if tableview.indexPath(for: cell)?.section == 1 {
            UserDefaults.standard.set(bonusName[row!][0], forKey: "BPName")
        }
        
    }
    
    @IBAction func reset(_ sender: Any) {
        let message = "合計ポイントを0にして履歴も削除してよろしいですか？"
        
        // アラートを作成
        let alert = UIAlertController(
            title: "ポイント初期化",
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { action in
            self.confirmReset()
                                        
        }))
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)

    }
    
    func confirmReset() {
        let message = "本当に初期化してよろしいですか？"
        
        // アラートを作成
        let alert = UIAlertController(
            title: "確認",
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "俺はヤル人生を選ぶ",
                                      style: .default,
                                      handler: { action in
                                        UserDefaults.standard.set(0, forKey: "myPoint")
                                        UserDefaults.standard.set(0, forKey: "getPoint")
                                        self.myPoint = 0
                                        self.getPoint = 0
                                        self.dispPoint.text = "\(self.myPoint)"
                                        
                                        let rirekiAray : Array<RirekiEntity> = []
                                        // serializing
                                        let archiveData = NSKeyedArchiver.archivedData(withRootObject: rirekiAray)
                                        UserDefaults.standard.set(archiveData, forKey: "rireki")
                                        
        }))
        
        alert.addAction(UIAlertAction(title: "ヤラナイ", style: .cancel))
        
        // アラート表示
        self.present(alert, animated: true, completion: nil)
    }
    
    func getYyyymmdd(format:String = "yyyy.MM.dd") -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    func getHhmm(format:String = "HH:mm") -> String {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    @IBAction func adjustPoint(_ sender: Any) {
        
        showAdustAlert()
        
    }
    
    func showAdustAlert() {
        
        let alert = UIAlertController(title: "ポイント調整", message: "", preferredStyle: .alert)
        // ポイントプラス
        let plusAction = UIAlertAction(title: "プラス", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            var rirekiExeFlg = false
            
            let yyyymmdd = self.getYyyymmdd()
            let hhmm = self.getHhmm()
            var rirekiPoint = ""
            var rirekiBonusName = "(手動ポイントプラス)"
            
            var rirekiAray : Array<RirekiEntity> = []
            
            // 自作のオブジェクトはData型に変換しないとUserDefaultsに出し入れできない
            if  let storedData = UserDefaults.standard.object(forKey:"rireki") as? Data {
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
                UserDefaults.standard.set(archiveData, forKey: "rireki")
                
                rirekiExeFlg = false
                
                if UserDefaults.standard.object(forKey:"myPoint") != nil {
                    self.myPoint = UserDefaults.standard.object(forKey:"myPoint") as! Int
                }
                
                self.myPoint += Int(rirekiPoint)!
                
                UserDefaults.standard.set(self.myPoint, forKey: "myPoint")
                UserDefaults.standard.set(Int(rirekiPoint)!, forKey: "getPoint")
                self.dispPoint.text = "\(self.myPoint)"
            }
            
        })
        alert.addAction(plusAction)

        // ポイントマイナス
        let minusAction = UIAlertAction(title: "マイナス", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            var rirekiExeFlg = false
            
            let yyyymmdd = self.getYyyymmdd()
            let hhmm = self.getHhmm()
            var rirekiPoint = ""
            var rirekiBonusName = "(手動ポイントマイナス)"
            
            var rirekiAray : Array<RirekiEntity> = []
            
            // 自作のオブジェクトはData型に変換しないとUserDefaultsに出し入れできない
            if  let storedData = UserDefaults.standard.object(forKey:"rireki") as? Data {
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
                UserDefaults.standard.set(archiveData, forKey: "rireki")
                rirekiExeFlg = false
                
                if UserDefaults.standard.object(forKey:"myPoint") != nil {
                    self.myPoint = UserDefaults.standard.object(forKey:"myPoint") as! Int
                }
                
                self.myPoint += Int(rirekiPoint)!
                
                UserDefaults.standard.set(self.myPoint, forKey: "myPoint")
                UserDefaults.standard.set(Int(rirekiPoint)!, forKey: "getPoint")
                self.dispPoint.text = "\(self.myPoint)"

                
            }
            
        })
        alert.addAction(minusAction)
        
        // キャンセルボタンの設定
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextField(configurationHandler: {(point: UITextField!) -> Void in
            point.placeholder = "1から10でポイント入力してください"
            point.keyboardType = UIKeyboardType.numberPad
            // 初期フォーカス
            point.becomeFirstResponder()
        })
        
        alert.addTextField(configurationHandler: {(reason: UITextField!) -> Void in
            reason.placeholder = "理由があれば入力してください"
        })
        
        alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
        
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
        // 戻るボタン
    }
    
}

