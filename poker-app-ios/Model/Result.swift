//
//  Result.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/26.
//

import UIKit

struct ResultsContainer: Decodable {
    var results: [Result]
}

struct Result: Decodable {
    var cards: String
    var hand: String
}
