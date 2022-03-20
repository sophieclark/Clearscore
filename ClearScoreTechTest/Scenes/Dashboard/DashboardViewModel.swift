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
    @Published var creditResult: CreditResult = .loading
    private let creditFetcher: CreditFetchable
    private var cancellables = Set<AnyCancellable>()
    private var creditAccount: CreditAccount?
    
    init(creditFetcher: CreditFetchable) {
        self.creditFetcher = creditFetcher
    }
    
    func refresh() {
        creditResult = .loading
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
                self.creditAccount = creditAccount
            })
            .store(in: &cancellables)
    }
    
    func errorViewModel(for error: NetworkingError) -> ErrorViewModel {
        switch error {
        case .parsing:
            return ErrorViewModel(errorTitle: String(localized: "errorview.title.text"), errorDescription: String(localized: "errorview.description.parsing.text"), buttonText: String(localized: "errorview.button.text"))
        case .network:
            return ErrorViewModel(errorTitle: String(localized: "errorview.title.text"), errorDescription: String(localized: "errorview.description.network.text"), buttonText: String(localized: "errorview.button.text"))
        case .url:
            return ErrorViewModel(errorTitle: String(localized: "errorview.title.text"), errorDescription: String(localized: "errorview.description.url.text"), buttonText: String(localized: "errorview.button.text"))
        }
    }
}

extension DashboardViewModel.CreditResult: Equatable {
    static func == (lhs: DashboardViewModel.CreditResult, rhs: DashboardViewModel.CreditResult) -> Bool {
        switch (lhs, rhs) {
        case (.success(_), .success(_)), (.loading, .loading), (.error(_), .error(_)):
            return true
        default:
            return false
        }
    }
}
