//
//  Const.swift
//  CanonBallApp
//
//  Created by 池田拓馬 on 2018/02/12.
//  Copyright © 2018年 eglab. All rights reserved.
//

import Foundation

class Const {
    
    /*
     アラートで使うメッセージ
     */
    final class Message {
        /*
         ポイント初期化
         */
        static let deleteMsg = "合計ポイントを0にして履歴も削除してよろしいですか？"
        static let confirmDeleteMsg = "本当に初期化してよろしいですか？"
        static let deleteMsgTitle = "ポイント初期化"
        static let confirmDeleteMsgTitle = "確認"
        static let ok01 = "OK"
        static let cancel01 = "キャンセル"
        static let ok02 = "俺はヤル人生を選ぶ"
        static let cancel02 = "ヤラナイ"
        /*
         ポイント操作
         */
        static let adjustMsgTitle = "ポイント調整"
        static let plus = "プラス"
        static let minus = "マイナス"
        static let plusInfoMsg = "(手動ポイントプラス)"
        static let minusInfoMsg = "(手動ポイントマイナス)"
        static let addMsgTitle = "ポイント追加"
        static let addOk = "OK"
        static let addCancel = "キャンセル"
        static let adjustCancel = "キャンセル"
        static let adjustMsg = "1から10でポイント入力してください"
        static let reasonMsg = "理由があれば入力してください"
    }
    
    /*
     レース順位に紐づく情報の配列
     */
    final class RaceInfo {
        static let raceName: [[String]] = [
            ["レース1着", "10", "RN00"],
            ["レース2着", "5", "RN01"],
            ["レース3着", "1", "RN02"],
            ["どぼん", "-5", "RN03"]
        ]
    }
    
    /*
     ボーナス特典に紐づく情報の配列
     */
    final class BonusInfo {
        // ボーナスポイント名、ボーナスポイント、メッセージコード(mCode)
        static let bonusName: [[String]] = [
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
    }
    
    /*
     Sectionで使用する配列
     */
    final class SectionConst {
        static let mySections = ["レ ー ス ポ イ ン ト", "ビ ン ボ ー ポ イ ン ト"]
    }
    
    /*
     ポイント一覧のタップで表示されるメッセージ
     */
    final class PointInfo {
        static let RN00 = "1着"
        static let RN01 = "2着"
        static let RN02 = "3着"
        static let RN03 = "どぼん"
        
        static let BN00 = "あ"
        static let BN01 = "い"
        static let BN02 = "う"
        static let BN03 = "え"
        static let BN04 = "お"
        static let BN05 = "か"
        static let BN06 = "き"
        static let BN07 = "く"
        static let BN08 = "け"
        static let BN09 = "こ"
        static let BN10 = "さ"
        static let BN11 = "し"
        static let BN12 = "す"
        static let BN13 = "せ"
        static let BN14 = "そ"
        static let BN15 = "た"
        static let BN16 = "ち"
        static let BN17 = "つ"
        static let BN18 = "て"
        static let BN19 = "と"
        static let BN20 = "な"
        static let BN21 = "に"
        static let BN22 = "ぬ"
        static let BN23 = "ね"
        static let BN99 = "存在しないボーナス名です"
    }
    
    /*
     ユーザデフォルトで使うキー
     */
    final class Udkey {
        static let MYPOINT = "myPoint"
        static let GETPOINT = "getPoint"
        static let RIREKI = "rireki"
        static let BPNAME = "BPName"
    }
    
    final class RaceNameCode {
        static let RN00 = "RN00"
        static let RN01 = "RN01"
        static let RN02 = "RN02"
        static let RN03 = "RN03"
    }
    
    final class BonusNameCode {
        static let BN00 = "BN00"
        static let BN01 = "BN01"
        static let BN02 = "BN02"
        static let BN03 = "BN03"
        static let BN04 = "BN04"
        static let BN05 = "BN05"
        static let BN06 = "BN06"
        static let BN07 = "BN07"
        static let BN08 = "BN08"
        static let BN09 = "BN09"
        static let BN10 = "BN00"
        static let BN11 = "BN11"
        static let BN12 = "BN12"
        static let BN13 = "BN13"
        static let BN14 = "BN14"
        static let BN15 = "BN15"
        static let BN16 = "BN16"
        static let BN17 = "BN17"
        static let BN18 = "BN18"
        static let BN19 = "BN19"
        static let BN20 = "BN20"
        static let BN21 = "BN21"
        static let BN22 = "BN22"
        static let BN23 = "BN23"
    }
    
    
}
