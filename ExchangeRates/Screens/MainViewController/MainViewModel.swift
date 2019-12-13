//
//  MainViewModel.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 10.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Moya
import Moya_ObjectMapper
import RxSwift

class MainViewModel: MainProtocol {
    
    private let service = MoyaProvider<MoyaService>()

    func getLatestRatesWithBase(_ base: BaseRate, completion: @escaping ((Latest?, String?) -> Void)) {
        service.request(.latest(base: base)) { [weak self] (result) in
            switch result {
            case .success(let response):
                
                
                
                guard let data = try? response.mapObject(Latest.self) else { return }
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.errorDescription ?? "unknown error")
            }
        }
    }

}
