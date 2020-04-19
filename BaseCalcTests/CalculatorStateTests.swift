//
//  CalculatorStateTests.swift
//  BaseCalcTests
//
//  Created by Ricardo J. González on 14/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import XCTest

@testable import BaseCalc

class CalculatorStateTests: XCTestCase {
    
    private var state: CalculatorState!

    override func setUpWithError() throws {
        try super.setUpWithError()
        state = CalculatorState()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
        state = nil
    }
    
    //MARK:- Change Base Operation
    func testWholeNumberChangeBase() throws {
        state.currentText = "35"
        state.currentBase = .Base6
        state.changeBase(.Base10)
        XCTAssertEqual(state.currentText, "23")
    }
    
    func testFloatNumberChangeBase() {
        state.currentText = "101.1"
        state.currentBase = .Base2
        state.changeBase(.Base10)
        XCTAssertEqual(state.currentText, "5.5")
    }

    func testWholeNumberWithPointChangeBase() throws {
        state.currentText = "10."
        state.currentBase = .Base10
        state.changeBase(.Base4)
        XCTAssertEqual(state.currentText, "22")
    }

}
