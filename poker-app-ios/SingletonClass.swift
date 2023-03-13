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
    
    var isErrorInputPresent = true
    
    func getIsErrorInputPresent() -> Bool {
        return isErrorInputPresent
    }
    
    func setIsErrorInputPresent(isError: Bool) {
        isErrorInputPresent = isError
    }
}
