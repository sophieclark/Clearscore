//
//  Networkable.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 19/03/2022.
//

import Foundation
import Combine

enum NetworkingError: Error {
    case url(description: String)
    case network(description: String)
    case parsing(description: String)
}

protocol Networkable {
    func fetch<T>(with session: URLSession, and components: URLComponents, decoder: JSONDecoder) -> AnyPublisher<T, NetworkingError> where T: Decodable
}

extension Networkable {
    func fetch<T>(with session: URLSession = .shared, and components: URLComponents, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, NetworkingError> where T: Decodable {
        guard let url = components.url else {
          let error = NetworkingError.url(description: "Couldn't create URL")
          return Fail(error: error).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        return session.dataTaskPublisher(for: urlRequest)
            .mapError({ urlError in
                NetworkingError.url(description: urlError.localizedDescription)
            })
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .mapError({ error in
                NetworkingError.parsing(description: error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
}
