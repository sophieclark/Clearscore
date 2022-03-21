//
//  ScoreViewModelTests.swift
//  ClearScoreTechTestTests
//
//  Created by Sophie Clark on 21/03/2022.
//

import XCTest
@testable import ClearScoreTechTest

class ScoreViewModelTests: XCTestCase {

    func test_valuesAssignCorrectly() {
        let sut = ScoreViewModel(score: 500, max: 700)
        XCTAssertEqual(sut.score, 500)
        XCTAssertEqual(sut.max, 700)
        XCTAssertEqual(sut.topLabelText, "Your credit score is")
        XCTAssertEqual(sut.bottomLabelText, "out of 700")
    }

}
