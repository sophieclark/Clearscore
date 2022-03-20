//
//  CreditReportViewModel.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 20/03/2022.
//

import Foundation

struct CreditReportViewModel {
    
    private let creditAccount: CreditAccount
    
    //header
    var creditScore: Int
    var maxScore: Int
    
    //changes
    var hasShortTermDebt: Bool
    var shortTermDebtChange: Int
    var hasLongTermDebt: Bool
    var longTermDebtChange: Int
    
    //insights
    var monthsSinceLastMissedPayment: Int?
    var hasEverDefaulted: Bool
    
    //credit utilisation
    
    
    init(creditAccount: CreditAccount) {
        self.creditAccount = creditAccount
        
        self.creditScore = creditAccount.creditReportInfo.score
        self.maxScore = creditAccount.creditReportInfo.maxScoreValue
        
        self.hasShortTermDebt = creditAccount.creditReportInfo.currentShortTermDebt <= 0
        self.shortTermDebtChange = creditAccount.creditReportInfo.changeInShortTermDebt
        self.hasLongTermDebt = creditAccount.creditReportInfo.currentLongTermDebt <= 0
        self.longTermDebtChange = creditAccount.creditReportInfo.changeInLongTermDebt
        
        self.hasEverDefaulted = creditAccount.creditReportInfo.hasEverDefaulted
    }
}
