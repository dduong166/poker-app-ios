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
