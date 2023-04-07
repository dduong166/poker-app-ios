//
//  Result.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/26.
//

import UIKit

//カードセットのhand確認結果の一覧のObject
struct ResultsContainer: Decodable {
    var results: [Result]
}

//カードセットのhand確認結果のObject
struct Result: Decodable {
    var cards: String
    var hand: String
}
