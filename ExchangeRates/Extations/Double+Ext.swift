//
//  Double+Ext.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Foundation

extension Double {
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Double) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
