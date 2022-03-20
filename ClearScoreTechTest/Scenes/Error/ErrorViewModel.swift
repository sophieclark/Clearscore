//
//  ErrorViewModel.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 20/03/2022.
//

import Foundation
import Combine

struct ErrorViewModel {
    var errorTitle: String
    var errorDescription: String
    var buttonText: String
    var retryTapped = PassthroughSubject<Bool, Never>()
}
