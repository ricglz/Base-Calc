//
//  NumberTests.swift
//  BaseCalcTests
//
//  Created by Juan Lizarraga on 20/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import XCTest

@testable import BaseCalc

class NumberTests: XCTestCase {

    private var number: Number!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        number = nil
    }

    //MARK:- Testing value of numbers

    func testWholePositiveValue() {
        number = Number(number: "FA", base: .Base16)
        XCTAssertEqual(number.value, 250)
    }

    func testWholeNegativeValue() {
        number = Number(number: "-121", base: .Base3)
        XCTAssertEqual(number.value, -16)
    }

    func testFloatingPositiveValue() {
        number = Number(number: "10.3", base: .Base8)
        XCTAssertEqual(number.value, 8.375)
    }

    func testFloatingNegativeValue() {
        number = Number(number: "-2.4C", base: .Base15)
        XCTAssertEqual(number.value, -2.32)
    }

    func testWholeWithDecimalValue() {
        number = Number(number: "10.0000", base: .Base10)
        XCTAssertEqual(number.value, 10)
    }

    func testWholeWithPointValue() {
        number = Number(number: "10.", base: .Base10)
        XCTAssertEqual(number.value, 10)
    }

    //MARK:- Testing hasFract of numbers

    func testWholePositiveFract() {
        number = Number(number: "F", base: .Base16)
        XCTAssertEqual(number.hasFract, false)
    }

    func testWholeNegativeFract() {
        number = Number(number: "-42", base: .Base5)
        XCTAssertEqual(number.hasFract, false)
    }

    func testFloatingPositiveFract() {
        number = Number(number: "3.14", base: .Base8)
        XCTAssertEqual(number.hasFract, true)
    }

    func testFloatingNegativeFract() {
        number = Number(number: "-0.15", base: .Base10)
        XCTAssertEqual(number.hasFract, true)
    }

    func testWholeWithDecimalFract() {
        number = Number(number: "3.00000", base: .Base10)
        XCTAssertEqual(number.hasFract, false)
    }

    func testWholeWithPointFract() {
        number = Number(number: "3.", base: .Base13)
        XCTAssertEqual(number.hasFract, false)
    }

    //MARK:- Testing string display of numbers

    func testWholePostiveToString() {
        number = Number(number: "29", base: .Base11)
        XCTAssertEqual(number.toString(), "29")
    }

    func testWholeNegativeToString() {
        number = Number(number: "-74", base: .Base11)
        XCTAssertEqual(number.toString(), "-74")
    }

    func testFloatPostiveToString() {
        number = Number(number: "25.11", base: .Base11)
        XCTAssertEqual(number.toString(), "25.11")
    }

    func testFloatNegativeToString() {
        number = Number(number: "-33.69", base: .Base11)
        XCTAssertEqual(number.toString(), "-33.69")
    }

    func testWholeDecimalToString() {
        number = Number(number: "5.000000", base: .Base14)
        XCTAssertEqual(number.toString(), "5")
    }

    func testWholeWithPointToString() {
        number = Number(number: "2.", base: .Base4)
        XCTAssertEqual(number.toString(), "2")
    }


    //MARK:- Testing conversion of numbers

    func testConversionToBiggerBase() {
        number = Number(number: "1010.1011", base: .Base2)
        XCTAssertEqual(number.toString(base: .Base16), "A.B")
    }

    func testConversionToSmallerBase() {
        number = Number(number: "1A.8", base: .Base12)
        XCTAssertEqual(number.toString(base: .Base9), "24.6")
    }

}
