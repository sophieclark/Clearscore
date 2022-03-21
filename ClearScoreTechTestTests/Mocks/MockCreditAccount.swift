//
//  MockCreditAccount.swift
//  ClearScoreTechTestTests
//
//  Created by Sophie Clark on 21/03/2022.
//

import Foundation
@testable import ClearScoreTechTest

class MockCreditAccount {
    static func makeCreditAccount(changeInShortTermDebt: Int = 0,
                                               changeInLongTermDebt: Int = 0,
                                               hasEverDefaulted: Bool = false,
                                               monthsSinceLastDefaulted: Int = 0,
                                               monthsSinceLastDelinquent: Int = 0,
                                               hasEverBeenDelinquent: Bool = false) -> CreditAccount {
                    return CreditAccount(accountIDVStatus: "PASS",
                                         creditReportInfo: CreditReportInfo(score: 514,
                                                                            scoreBand: 4,
                                                                            clientRef: "CS-SED-655426-708782",
                                                                            status: "MATCH",
                                                                            maxScoreValue: 700,
                                                                            minScoreValue: 0,
                                                                            monthsSinceLastDefaulted: monthsSinceLastDefaulted,
                                                                            hasEverDefaulted: hasEverDefaulted,
                                                                            monthsSinceLastDelinquent: monthsSinceLastDelinquent,
                                                                            hasEverBeenDelinquent: hasEverBeenDelinquent,
                                                                            percentageCreditUsed: 44,
                                                                            percentageCreditUsedDirectionFlag: 1,
                                                                            changedScore: 0,
                                                                            currentShortTermDebt: 13758,
                                                                            currentShortTermNonPromotionalDebt: 13758,
                                                                            currentShortTermCreditLimit: 30600,
                                                                            currentShortTermCreditUtilisation: 44,
                                                                            changeInShortTermDebt: changeInShortTermDebt,
                                                                            currentLongTermDebt: 24682,
                                                                            currentLongTermNonPromotionalDebt: 24682,
                                                                            currentLongTermCreditLimit: nil,
                                                                            currentLongTermCreditUtilisation: nil,
                                                                            changeInLongTermDebt: changeInLongTermDebt,
                                                                            numPositiveScoreFactors: 9,
                                                                            numNegativeScoreFactors: 0,
                                                                            equifaxScoreBand: 4,
                                                                            equifaxScoreBandDescription: "Excellent",
                                                                            daysUntilNextReport: 9),
                                         dashboardStatus: "PASS",
                                         personaType: "INEXPERIENCED",
                                         coachingSummary: CoachingSummary(activeTodo: false,
                                                                          activeChat: true,
                                                                          numberOfTodoItems: 0,
                                                                          numberOfCompletedTodoItems: 0,
                                                                          selected: true),
                                         augmentedCreditScore: nil)
                }
}
