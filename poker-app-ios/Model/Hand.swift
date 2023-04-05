//
//  Hand.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/06.
//

import UIKit

struct Hand {
    var inputCard1: String
    var inputCard2: String
    var inputCard3: String
    var inputCard4: String
    var inputCard5: String
    
    func mergeCard() -> String {
        return inputCard1 + " " + inputCard2 + " " + inputCard3 + " " + inputCard4 + " " + inputCard5
    }
}

//struct Hand: Encodable {
//    var inputCard1: String
//    var inputCard2: String
//    var inputCard3: String
//    var inputCard4: String
//    var inputCard5: String
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(inputCard1, forKey: .inputCard1)
//        try container.encode(inputCard2, forKey: .inputCard2)
//        try container.encode(inputCard3, forKey: .inputCard3)
//        try container.encode(inputCard4, forKey: .inputCard4)
//        try container.encode(inputCard5, forKey: .inputCard5)
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case inputCard1
//        case inputCard2
//        case inputCard3
//        case inputCard4
//        case inputCard5
//    }
//}
