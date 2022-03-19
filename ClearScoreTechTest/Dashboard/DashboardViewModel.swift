//
//  DashboardViewModel.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import Combine
import Foundation

class DashboardViewModel: ObservableObject {
    enum CreditResult {
        case success(ScoreViewModel)
        case loading
        case error(NetworkingError)
    }
    @Published var creditResult: CreditResult
    private let creditFetcher: CreditFetchable
    private var cancellables = Set<AnyCancellable>()
    private let creditAccount: CreditAccount?
    
    init(creditFetcher: CreditFetchable) {
        self.creditFetcher = creditFetcher
    }
    
    func refresh() {
        creditFetcher.getCreditScore()
            .receive(on: DispatchQueue.main, options: nil)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    self.creditResult = .error(error)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] creditAccount in
                guard let self = self else { return }
                let scoreViewModel = ScoreViewModel(score: creditAccount.creditReportInfo.score, max: creditAccount.creditReportInfo.maxScoreValue)
                self.creditResult = .success(scoreViewModel)
            })
            .store(in: &cancellables)
    }
}
