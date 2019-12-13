//
//  DetailProtocol.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import RxSwift

protocol DetailProtocol: class {
    
    func getHistoryWithBase(_ base: BaseRate, symbols: String, startAt: String, endAt: String, completion: @escaping ((History?, String?) -> Void))
    
}

