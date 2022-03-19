//
//  CreditFetchable.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Combine

protocol CreditFetchable {
    func getCreditScore() -> AnyPublisher<CreditAccount, NetworkingError>
}
