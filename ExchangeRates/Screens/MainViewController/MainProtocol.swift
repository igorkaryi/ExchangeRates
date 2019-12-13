//
//  MainProtocol.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 10.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import RxSwift

protocol MainProtocol: class {
    
    func getLatestRatesWithBase(_ base: BaseRate, completion: @escaping ((Latest?, String?) -> Void))
    
}
