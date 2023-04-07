//
//  History.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/04/03.
//

import RealmSwift

//データベースに保存される履歴
class HistoryRealm: Object {
    @objc dynamic var cards = ""
    @objc dynamic var hand = ""
    @objc dynamic var created_at = Date(timeIntervalSince1970: 1)
}

