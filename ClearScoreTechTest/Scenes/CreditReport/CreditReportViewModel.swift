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
    let missedPayemntsText: String
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
        self.shortTermDebtChangeTitle = Self.getShortTermDebtChange(from: creditAccount)
        
        self.hasLongTermDebt = creditAccount.creditReportInfo.currentLongTermDebt <= 0
        self.longTermDebtChange = creditAccount.creditReportInfo.changeInLongTermDebt
        self.longTermDebtTitle = String(localized: "creditreport.longtermdebt.title")
        self.longTermDebtChangeTitle = Self.getLongTermDebtChange(from: creditAccount)
        
        self.longTermDebtValue = creditAccount.creditReportInfo.currentLongTermDebt
        
        self.insightsTitle = String(localized: "creditreport.insights.title")
        
        self.defaultedText = Self.getDefaultedText(from: creditAccount)
        
        self.missedPayemntsText = Self.getMissedPaymentsText(from: creditAccount)
    }
    
    static func getShortTermDebtChange(from creditAccount: CreditAccount) -> String {
        let shortTermDebtChange = creditAccount.creditReportInfo.changeInShortTermDebt
        if shortTermDebtChange > 0 {
            return String(localized: "creditreport.shorttermdebt.increased.text")
        } else if shortTermDebtChange < 0 {
            return String(localized: "creditreport.shorttermdebt.decreased.text")
        } else {
            return String(localized: "creditreport.shorttermdebt.nochange.text")
        }
    }
    
    static func getLongTermDebtChange(from creditAccount: CreditAccount) -> String {
        let longTermDebtChange = creditAccount.creditReportInfo.changeInLongTermDebt
        if longTermDebtChange > 0 {
            return String(localized: "creditreport.longtermdebt.increased.text")
        } else if longTermDebtChange < 0 {
            return String(localized: "creditreport.longtermdebt.decreased.text")
        } else {
            return String(localized: "creditreport.longtermdebt.nochange.text")
        }
    }
    
    static func getDefaultedText(from creditAccount: CreditAccount) -> String {
        if creditAccount.creditReportInfo.hasEverDefaulted {
            if creditAccount.creditReportInfo.monthsSinceLastDefaulted > 1 {
                return String(format: "creditreport.insights.defaults.pluralmonths.text".localized(), creditAccount.creditReportInfo.monthsSinceLastDefaulted)
            } else {
                return String(format: "creditreport.insights.defaults.onemonth.text".localized())
            }
        } else {
            return String(localized: "creditreport.insights.nodefaults.text")
        }
    }
    
    static func getMissedPaymentsText(from creditAccount: CreditAccount) -> String {
        let monthsSinceLastMissedPayment = creditAccount.creditReportInfo.monthsSinceLastDelinquent
        if !creditAccount.creditReportInfo.hasEverBeenDelinquent {
            return String(localized: "creditreport.insights.nomissedpayments.text")
        } else if monthsSinceLastMissedPayment > 1 {
            return String(format: "creditreport.insights.missedpayments.pluralmonths.text".localized(), monthsSinceLastMissedPayment)
        } else {
            return String(localized: "creditreport.insights.missedpayments.onemonth.text")
        }
    }
}
