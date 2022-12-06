//
//  NetworkLayer.swift
//  
//
//  Created by Matloob on 7/20/20.
//  Copyright © 2020 Matloob. All rights reserved.
//

import UIKit

import Foundation
import Moya


// used as global "needs to be enhaced"
let appNetworkProvider = MoyaProvider<AppNetwork>()
let apikey = "WQxXngS7FvsoyPF7hBO8bbb6N6rTFYv8"

enum AppNetwork {
    case fetchAllCurrencies
    case getConversion(amount: Double, to: String, from: String)
}

extension AppNetwork: TargetType {
    var sampleData: Data {
        Data()
    }
    
    
    public var headers: [String : String]? {
        return ["apikey":apikey]
    }
    
    
    var baseURL: URL {
        switch APIConstants.applicationMode {
        case .production:
            return URL(string: "https://api.apilayer.com/")!
        case .qa:
            return URL(string: "https://api.apilayer.com/")!
        case .development:
            return URL(string: "https://api.apilayer.com/")!
        }
    }
    
    // dermine resource path for each end point in 'AppNetwork' enum with Base Url
    var path: String {
        switch self {
        case .fetchAllCurrencies:
            return "fixer/symbols"
        case  let.getConversion(amount, to, from):
            return "convert?to=\(to)from=\(from)amount=\(amount)"
        }
    }
    
    // detrmine HTTP method "GET, POST, PUT .. etc"
    var method: Moya.Method {
        switch self {
        case .fetchAllCurrencies:
            return .get
        case .getConversion:
            return .get
            
        }
    }
    
    
    
    var parameters: [String: Any]? {
        switch self {
        case .fetchAllCurrencies, .getConversion:
            return nil
        }
    }
    
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .fetchAllCurrencies:
            return JSONEncoding.default
        case .getConversion:
            return JSONEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        case .fetchAllCurrencies, .getConversion:
            return .requestPlain
            
        }
        
    }
    
    class APIConstants: NSObject {
        
        enum type {
            case development
            case qa
            case production
        }
        
        /// Change application running mode type here
        static let applicationMode: APIConstants.type = .development
        
    }
}
