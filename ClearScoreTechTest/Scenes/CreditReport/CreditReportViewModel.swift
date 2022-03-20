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
    let creditScore: Int
    let outOfText: String
    
    //changes
    let changesTitle: String
    let hasShortTermDebt: Bool
    let shortTermDebtTitle: String
    let shortTermDebtChangeTitle: String
    let shortTermDebtChange: Int
    let shortTermDebtValue: Int
    let longTermDebtTitle: String
    let longTermDebtChangeTitle: String
    let hasLongTermDebt: Bool
    let longTermDebtChange: Int
    let longTermDebtValue: Int
    
    //insights
    let insightsTitle: String
    let monthsSinceLastMissedPayment: Int
    let missedPayemntsText: String
    let hasEverDefaulted: Bool
    let defaultedText: String
    
    //credit utilisation
    
    
    init(creditAccount: CreditAccount) {
        self.creditAccount = creditAccount
        
        self.creditScore = creditAccount.creditReportInfo.score
        self.outOfText =  String(format: "scoreview.bottom.label".localized(), creditAccount.creditReportInfo.maxScoreValue) 
        
        self.changesTitle = String(localized: "creditreport.changes.title")
        
        self.shortTermDebtTitle = String(localized: "creditreport.shorttermdebt.title")
        self.hasShortTermDebt = creditAccount.creditReportInfo.currentShortTermDebt <= 0
        self.shortTermDebtChange = creditAccount.creditReportInfo.changeInShortTermDebt
        self.shortTermDebtValue = creditAccount.creditReportInfo.currentShortTermDebt
        if shortTermDebtChange > 0 {
            self.shortTermDebtChangeTitle = String(localized: "creditreport.shorttermdebt.increased.text")
        } else if shortTermDebtChange < 0 {
            self.shortTermDebtChangeTitle = String(localized: "creditreport.shorttermdebt.decreased.text")
        } else {
            self.shortTermDebtChangeTitle = String(localized: "creditreport.shorttermdebt.nochange.text")
        }
        
        self.hasLongTermDebt = creditAccount.creditReportInfo.currentLongTermDebt <= 0
        self.longTermDebtChange = creditAccount.creditReportInfo.changeInLongTermDebt
        self.longTermDebtTitle = String(localized: "creditreport.longtermdebt.title")
        if longTermDebtChange > 0 {
            self.longTermDebtChangeTitle = String(localized: "creditreport.longtermdebt.increased.text")
        } else if longTermDebtChange < 0 {
            self.longTermDebtChangeTitle = String(localized: "creditreport.longtermdebt.decreased.text")
        } else {
            self.longTermDebtChangeTitle = String(localized: "creditreport.longtermdebt.nochange.text")
        }
        
        self.longTermDebtValue = creditAccount.creditReportInfo.currentLongTermDebt
        
        self.insightsTitle = String(localized: "creditreport.insights.title")
        self.hasEverDefaulted = creditAccount.creditReportInfo.hasEverDefaulted
        if hasEverDefaulted {
            if creditAccount.creditReportInfo.monthsSinceLastDefaulted > 1 {
                self.defaultedText = String(format: "creditreport.insights.defaults.pluralmonths.text".localized(), creditAccount.creditReportInfo.monthsSinceLastDefaulted)
            } else {
                self.defaultedText = String(format: "creditreport.insights.defaults.onemonth.text".localized())
            }
        } else {
            self.defaultedText = String(localized: "creditreport.insights.nodefaults.text")
        }
        
        self.monthsSinceLastMissedPayment = creditAccount.creditReportInfo.monthsSinceLastDelinquent
        if creditAccount.creditReportInfo.hasEverBeenDelinquent {
            missedPayemntsText = String(localized: "creditreport.insights.nomissedpayments.text")
        } else if monthsSinceLastMissedPayment <=  1 {
            missedPayemntsText = String(format: "creditreport.insights.missedpayments.pluralmonths.text", monthsSinceLastMissedPayment)
        } else {
            missedPayemntsText = String(localized: "creditreport.insights.missedpayments.onemonth.text")
        }
    }
}
