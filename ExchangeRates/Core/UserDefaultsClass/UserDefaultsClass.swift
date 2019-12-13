//
//  UserDefaultsClass.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let time = "TimeKey"
}

class UserDefaultsClass {

    func saveTime(value: Date, key: String) {
       UserDefaults.standard.set(value, forKey: key)
       UserDefaults.standard.synchronize()
    }
    
    func getTime(key: String) -> Date? {
        let value = UserDefaults.standard.object(forKey: key) as? Date
        return value
    }
    
}
