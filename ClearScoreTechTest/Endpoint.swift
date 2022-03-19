//
//  Endpoint.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Foundation

class Endpoint {
    struct API {
        let scheme: String
        let host: String
        let path: String
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
