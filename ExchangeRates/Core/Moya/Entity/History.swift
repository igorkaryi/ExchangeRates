//
//  History.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import ObjectMapper

struct History {
    var base  : String?
    var startAt  : String?
    var endAt  : String?
    var rates : HistoryRates?
}

extension History: Mappable {
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        base <- map["base"]
        startAt <- map["start_at"]
        endAt <- map["end_at"]
        rates <- map["rates"]
    }
    
}
