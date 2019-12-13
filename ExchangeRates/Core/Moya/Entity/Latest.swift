//
//  Latest.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 10.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import ObjectMapper

struct Latest {
    var base  : String?
    var date  : String?
    var rates : Rates?
}

extension Latest: Mappable {
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        base <- map["base"]
        date <- map["date"]
        rates <- map["rates"]
    }
    
}
