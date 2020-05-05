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
        state.willPerformOperation = true
        state.addDigit(".")
        XCTAssertEqual(state.currentText, "0.")
        XCTAssertFalse(state.willPerformOperation)
        XCTAssertTrue(state.hasDecimalDot)
    }

    func addRandomDigitAndAsertPresence() {
        let randomDigit = String(Int.random(in: 1..<10))
        state.addDigit(randomDigit)
        XCTAssertEqual(state.currentText.last, randomDigit.first)
    }

    func testWillPerformAritmeticAddDigit() {
        state.willPerformOperation = true
        addRandomDigitAndAsertPresence()
        XCTAssertFalse(state.willPerformOperation)
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
        state.currentText = "0"
        addRandomDigitAndAsertPresence()
    }

    func testZeroTestAddDot() {
        state.currentText = "0"
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
        state.willPerformOperation = true
        state.isNegative = true
        state.prevOperation = .add
        state.prevNumber = Number(number: "0", base: .Base10)
        state.allClear()
        XCTAssertEqual(state.currentText, "0")
        XCTAssertFalse(state.hasDecimalDot)
        XCTAssertFalse(state.willPerformOperation)
        XCTAssertFalse(state.isNegative)
        XCTAssertNil(state.prevOperation)
        XCTAssertNil(state.prevNumber)
    }

    //MARK:- Numerical operations

    func numericalOperationsAux(_ operation: () -> (),  _ prevOperation: String) {
        operation()
        XCTAssertTrue(state.willPerformOperation)
        XCTAssertEqual(state.prevOperation?.rawValue, prevOperation)
    }

    func testSum() {
        let sum = { self.state.performOperation(op: .add) }
        numericalOperationsAux(sum, "+")
    }

    func testSubtract() {
        let subtract = { self.state.performOperation(op: .subtract) }
        numericalOperationsAux(subtract, "-")
    }

    func testMultiplication() {
        let multiply = { self.state.performOperation(op: .multiply) }
        numericalOperationsAux(multiply, "x")
    }

    func testDivision() {
        let divide = { self.state.performOperation(op: .divide) }
        numericalOperationsAux(divide, "÷")
    }

    //MARK:- Bitwise operations

    func testAnd() {
        let and = { self.state.performOperation(op: .and) }
        numericalOperationsAux(and, "AND")
    }

    func testOr() {
        let or = { self.state.performOperation(op: .or) }
        numericalOperationsAux(or, "OR")
    }

    func testXor() {
        let xor = { self.state.performOperation(op: .xor) }
        numericalOperationsAux(xor, "XOR")
    }

    func testNor() {
        let nor = { self.state.performOperation(op: .nor) }
        numericalOperationsAux(nor, "NOR")
    }

    func testLeftShift1() {
        let leftShift1 = { self.state.performOperation(op: .leftShift1) }
        numericalOperationsAux(leftShift1, "<<")
    }

    func testLeftShiftN() {
        let leftShiftN = { self.state.performOperation(op: .leftShiftN) }
        numericalOperationsAux(leftShiftN, "X<<Y")
    }

    func testRightShift1() {
        let rightShift1 = { self.state.performOperation(op: .rightShift1) }
        numericalOperationsAux(rightShift1, ">>")
    }

    func testRightShiftN() {
        let rightShiftN = { self.state.performOperation(op: .rightShiftN) }
        numericalOperationsAux(rightShiftN, "X>>Y")
    }

    //MARK:- Change Sign Operation

    func testChangeSignOfZero() {
        state.currentText = "0"
        state.changeSign()
        XCTAssertEqual(state.currentText, "0")
        XCTAssertFalse(state.isNegative)
    }

    func testChangeSignOfPositiveNumber() {
        state.currentText = "13"
        state.changeSign()
        XCTAssertEqual(state.currentText, "-13")
        XCTAssertTrue(state.isNegative)
    }

    func testChangeSignOfNegativeNumber() {
        state.currentText = "-42.1516"
        state.isNegative = true
        state.changeSign()
        XCTAssertEqual(state.currentText, "42.1516")
        XCTAssertFalse(state.isNegative)
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

    //MARK:- Solve Operation
    func testSolveWithoutPreviousOperation() {
        state.solve()
        XCTAssertNil(state.prevNumber)
        XCTAssertEqual(state.currentText, "0")
        XCTAssertFalse(state.isNegative)
        XCTAssertNil(state.prevOperation)
    }

    func testSolveSumPositiveAnswer() {
        state.prevOperation = .add
        state.prevNumber = Number(number: "1", base: .Base10)
        state.currentText = "10"
        state.solve()
        XCTAssertEqual(state.prevNumber?.toString(), "11")
        XCTAssertEqual(state.currentText, "11")
        XCTAssertFalse(state.isNegative)
        XCTAssertNil(state.prevOperation)
    }

    func testSolveSumNegativeAnswer() {
        state.prevOperation = .add
        state.prevNumber = Number(number: "-90", base: .Base10)
        state.currentText = "10"
        state.solve()
        XCTAssertEqual(state.prevNumber?.toString(), "-80")
        XCTAssertEqual(state.currentText, "-80")
        XCTAssertTrue(state.isNegative)
        XCTAssertNil(state.prevOperation)
    }

    func testSolveSumWithoutPrevNumber() {
        state.prevOperation = .add
        state.currentText = "10"
        state.solve()
        XCTAssertEqual(state.prevNumber?.toString(), "20")
        XCTAssertEqual(state.currentText, "20")
        XCTAssertFalse(state.isNegative)
        XCTAssertNil(state.prevOperation)
    }

    func testSolveSubPositiveAnswer() {
        state.prevOperation = .subtract
        state.prevNumber = Number(number: "10", base: .Base10)
        state.currentText = "1"
        state.solve()
        XCTAssertEqual(state.prevNumber?.toString(), "9")
        XCTAssertEqual(state.currentText, "9")
        XCTAssertFalse(state.isNegative)
        XCTAssertNil(state.prevOperation)
    }

    func testSolveSubNegativeAnswer() {
        state.prevOperation = .subtract
        state.prevNumber = Number(number: "10", base: .Base10)
        state.currentText = "20"
        state.solve()
        XCTAssertEqual(state.prevNumber?.toString(), "-10")
        XCTAssertEqual(state.currentText, "-10")
        XCTAssertTrue(state.isNegative)
        XCTAssertNil(state.prevOperation)
    }

    func testSolveSubWithoutPrevNumber() {
        state.prevOperation = .subtract
        state.currentText = "10"
        state.solve()
        XCTAssertEqual(state.prevNumber?.toString(), "0")
        XCTAssertEqual(state.currentText, "0")
        XCTAssertFalse(state.isNegative)
        XCTAssertNil(state.prevOperation)
    }

    func testChainedOperations() {
        state.addDigit("2")
        state.performOperation(op: .add)
        state.addDigit("3")
        state.performOperation(op: .multiply)
        XCTAssertEqual(state.currentText, "5")
        XCTAssertTrue(state.isOperationSelected(op: .multiply))
        state.addDigit("4")
        state.solve()
        XCTAssertEqual(state.currentText, "20")
    }
}
