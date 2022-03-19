//
//  CreditFetcher.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Combine
import Foundation

class CreditFetcher {
    private let session: URLSession
    private let endpoint: Endpoint
    
    init(session: URLSession = .shared, endpoint: Endpoint) {
        self.session = session
        self.endpoint = endpoint
    }
}

extension CreditFetcher: CreditFetchable, Networkable {
    func getCreditScore() -> AnyPublisher<CreditAccount, NetworkingError> {
        fetch(with: session, and: endpoint.makeRequestComponents(), decoder: JSONDecoder())
    }
}
