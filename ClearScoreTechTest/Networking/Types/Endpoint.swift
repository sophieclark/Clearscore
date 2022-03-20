//
//  Endpoint.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Foundation

class Endpoint {
    struct API {
        var scheme: String
        var host: String
        var path: String
        
        init(scheme: String, host: String, path: String) {
            self.scheme = scheme
            self.host = host
            self.path = path 
        }
        
        init(url: URL) {
            self.scheme = url.scheme ?? "file"
            self.host = url.host ?? ""
            self.path = url.path
        }
    }
    var api: API
    
    init(api: API) {
        self.api = api
    }
    
    func makeRequestComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.host
        components.path = api.path
        
        return components
    }
}

enum Endpoints {
    case creditValues

    func getEndpoint() -> Endpoint {
        switch self {
        case .creditValues:
            return Endpoint(api: Endpoint.API(scheme: "https", host: "5lfoiyb0b3.execute-api.us-west-2.amazonaws.com", path: "/prod/mockcredit/values"))
        }
    }
    
    func getTestData(success: Bool) -> Endpoint {
        switch self {
        case .creditValues:
            if success {
                return Endpoint(api: Endpoint.API(url: URL(fileURLWithPath: Bundle.main.path(forResource: "mockcredit-values", ofType: "json")!)))
            } else {
                return Endpoint(api: Endpoint.API(url: URL(fileURLWithPath: Bundle.main.path(forResource: "mockcredit-values-fail", ofType: "json")!)))
            }
            
        }
    }
}
