//
//  Rates.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 10.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import ObjectMapper

struct Rates {
    var items = [Rate]()
}

struct Rate {
    var title : String?
    var value : Double?
}

extension Rates: Mappable {
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        items = map.JSON.compactMap({ Rate(title: $0.key, value: $0.value as? Double) })
    }
    
}
