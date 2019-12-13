//
//  DetailViewModel.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 11.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Moya
import Moya_ObjectMapper
import RxSwift

class DetailViewModel: DetailProtocol {
    
    private let service = MoyaProvider<MoyaService>()
    
    func getHistoryWithBase(_ base: BaseRate, symbols: String, startAt: String, endAt: String, completion: @escaping ((History?, String?) -> Void)) {
        service.request(.history(base: base, symbols: symbols, startAt: startAt, endAt: endAt)) { [weak self] (result) in
            switch result {
            case .success(let response):
        
                guard let data = try? response.mapObject(History.self) else { return }
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.errorDescription ?? "unknown error")
            }
        }
    }

}
