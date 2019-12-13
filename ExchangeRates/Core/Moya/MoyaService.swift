//
//  MoyaService.swift
//  ExchangeRates
//
//  Created by Igor Karyi on 10.12.2019.
//  Copyright © 2019 IK. All rights reserved.
//

import Moya

enum MoyaService {
    case latest(base: BaseRate)
    case history(base: BaseRate, symbols: String, startAt: String, endAt: String)
}

enum BaseRate: String {
    case usd = "USD"
}

extension MoyaService: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.exchangeratesapi.io")! }
    
    var path: String {
        switch self {
        case .latest: return "/latest"
        case .history: return "/history"
        }
    }

    var method: Moya.Method {
        switch self {
        case .latest, .history:
            return .get
        }
    }
    
    var task: Task {
        if let requestParameters = parameters {
            return .requestParameters(parameters: requestParameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .latest(let base):
            return ["base": base.rawValue]
        case .history(let base, let symbols, let startAt, let endAt):
            return [
                "base": base.rawValue,
                "symbols": symbols,
                "start_at": startAt,
                "end_at": endAt,
            ]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
