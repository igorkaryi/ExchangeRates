//
//  HistoryRates.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import ObjectMapper

struct HistoryRates {
    var items = [[HistoryRate]]()
}

struct HistoryRate {
    var date : String?
    var title : String?
    var value : Double?
}

extension HistoryRates: Mappable {
    
    init?(map: Map) {}
    
    // Mappable
    mutating func mapping(map: Map) {
        var ratesArray = [[HistoryRate]]()
        for item in map.JSON {
            guard let values: [String: Double] = item.value as? [String : Double] else { return }
            
            let rates = values.compactMap({ HistoryRate(date: item.key, title: $0.key, value: $0.value) })
            ratesArray.append(rates)
        }

        items = ratesArray
    }
    
}
