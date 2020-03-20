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
    
    func testConversionToBiggerBase() {
        number = Number(number: "1010.1011", base: .Base2)
        XCTAssertEqual(number.toString(base: .Base16), "A.B")
    }
    
    func testConversionToSmallerBase() {
        number = Number(number: "1A.8", base: .Base12)
        XCTAssertEqual(number.toString(base: .Base9), "24.6")
    }

}
