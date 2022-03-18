//
//  ScoreViewModel.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import Combine

struct ScoreViewModel {
    let topLabelText = String(localized: "scoreview.top.label")
    let bottomLabelText = String(localized: "scoreview.bottom.label")
    let score: Int
    
    init(score: Int) {
        self.score = score
    }
}

