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
    
    //MARK:- Add Digit operation
    func testWillPerformAritmeticAddDot() {
        state.willPerformArithmetic = true
        state.addDigit(".")
        XCTAssertEqual(state.currentText, "0.")
        XCTAssertFalse(state.willPerformArithmetic)
        XCTAssertTrue(state.hasDecimalDot)
    }
    
    func addRandomDigitAndAsertPresence() {
        let randomDigit = String(Int.random(in: 1..<10))
        state.addDigit(randomDigit)
        XCTAssertEqual(state.currentText.last, randomDigit.first)
    }
    
    func testWillPerformAritmeticAddDigit() {
        state.willPerformArithmetic = true
        addRandomDigitAndAsertPresence()
        XCTAssertFalse(state.willPerformArithmetic)
        XCTAssertFalse(state.hasDecimalDot)
    }
    
    func testHasDecimalAddDot() {
        state.currentText = "0."
        state.hasDecimalDot = true
        state.addDigit(".")
        XCTAssertEqual(state.currentText, "0.")
        XCTAssertTrue(state.hasDecimalDot)
    }
    
    func testZeroTestAddDigit() {
        addRandomDigitAndAsertPresence()
    }
    
    func testZeroTestAddDot() {
        state.addDigit(".")
        XCTAssertEqual(state.currentText, "0.")
        XCTAssertTrue(state.hasDecimalDot)
    }
    
    func testNotZeroTestAddDigit() {
        addRandomDigitAndAsertPresence()
        addRandomDigitAndAsertPresence()
    }
    
    //MARK:- All clear operation
    func testAllClear() {
        state.currentText = "-\(String(Int.random(in: 1..<10)))."
        state.hasDecimalDot = true
        state.willPerformArithmetic = true
        state.isNegative = true
        state.prevOperation = .add
        state.prevNumber = Number(number: "0", base: .Base10)
        state.allClear()
        XCTAssertEqual(state.currentText, "0")
        XCTAssertFalse(state.hasDecimalDot)
        XCTAssertFalse(state.willPerformArithmetic)
        XCTAssertFalse(state.isNegative)
        XCTAssertNil(state.prevOperation)
        XCTAssertNil(state.prevNumber)
    }
    
    //MARK:- Numerical operations
    
    func numericalOperationsAux(_ operation: () -> (),  _ prevOperation: String) {
        operation()
        XCTAssertTrue(state.willPerformArithmetic)
        XCTAssertEqual(state.prevOperation?.rawValue, prevOperation)
    }
    
    func testSum() {
        numericalOperationsAux(state.sum, "add")
    }
    
    func testSubstract() {
        numericalOperationsAux(state.substract, "substract")
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
