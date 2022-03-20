//
//  ScoreViewModel.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import Combine

struct ScoreViewModel {
    let topLabelText: String
    let bottomLabelText: String
    let score: Int
    let max: Int
    
    init(score: Int, max: Int) {
        self.score = score
        self.max = max
        self.topLabelText = String(localized: "scoreview.top.label")
        self.bottomLabelText = String(format: "scoreview.bottom.label".localized(), max)
    }
}

extension ScoreViewModel: Equatable {}
