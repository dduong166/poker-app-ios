//
//  SingletonClass.swift
//  poker-app-ios
//
//  Created by ズオン ダン on 2023/03/09.
//

import Foundation

class SingletonClass {
    static let shared = SingletonClass()
    
    private init() {}
    
    var hands = [Hand]()
        
    func getHands() -> [Hand] {
        return hands
    }
    
    func appendToHands(hand: Hand) {
        hands.append(hand)
    }
}

