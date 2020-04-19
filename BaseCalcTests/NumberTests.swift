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

    private var num1: Number!
    private var num2: Number!
    private var num3: Number!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        num1 = nil
        num2 = nil
        num3 = nil
    }

    //MARK:- Testing value of numbers

    func testWholePositiveValue() {
        num1 = Number(number: "FA", base: .Base16)
        XCTAssertEqual(num1.value, 250)
    }

    func testWholeNegativeValue() {
        num1 = Number(number: "-121", base: .Base3)
        XCTAssertEqual(num1.value, -16)
    }

    func testFloatingPositiveValue() {
        num1 = Number(number: "10.3", base: .Base8)
        XCTAssertEqual(num1.value, 8.375)
    }

    func testFloatingNegativeValue() {
        num1 = Number(number: "-2.4C", base: .Base15)
        XCTAssertEqual(num1.value, -2.32)
    }

    func testWholeWithDecimalValue() {
        num1 = Number(number: "10.0000", base: .Base10)
        XCTAssertEqual(num1.value, 10)
    }

    func testWholeWithPointValue() {
        num1 = Number(number: "10.", base: .Base10)
        XCTAssertEqual(num1.value, 10)
    }

    //MARK:- Testing hasFract of numbers

    func testWholePositiveFract() {
        num1 = Number(number: "F", base: .Base16)
        XCTAssertEqual(num1.hasFract, false)
    }

    func testWholeNegativeFract() {
        num1 = Number(number: "-42", base: .Base5)
        XCTAssertEqual(num1.hasFract, false)
    }

    func testFloatingPositiveFract() {
        num1 = Number(number: "3.14", base: .Base8)
        XCTAssertEqual(num1.hasFract, true)
    }

    func testFloatingNegativeFract() {
        num1 = Number(number: "-0.15", base: .Base10)
        XCTAssertEqual(num1.hasFract, true)
    }

    func testWholeWithDecimalFract() {
        num1 = Number(number: "3.00000", base: .Base10)
        XCTAssertEqual(num1.hasFract, false)
    }

    func testWholeWithPointFract() {
        num1 = Number(number: "3.", base: .Base13)
        XCTAssertEqual(num1.hasFract, false)
    }

    //MARK:- Testing string display of numbers

    func testWholePostiveToString() {
        num1 = Number(number: "29", base: .Base11)
        XCTAssertEqual(num1.toString(), "29")
    }

    func testWholeNegativeToString() {
        num1 = Number(number: "-74", base: .Base11)
        XCTAssertEqual(num1.toString(), "-74")
    }

    func testFloatingPostiveToString() {
        num1 = Number(number: "25.11", base: .Base11)
        XCTAssertEqual(num1.toString(), "25.11")
    }

    func testFloatingNegativeToString() {
        num1 = Number(number: "-33.69", base: .Base11)
        XCTAssertEqual(num1.toString(), "-33.69")
    }

    func testWholeDecimalToString() {
        num1 = Number(number: "5.000000", base: .Base14)
        XCTAssertEqual(num1.toString(), "5")
    }

    func testWholeWithPointToString() {
        num1 = Number(number: "2.", base: .Base4)
        XCTAssertEqual(num1.toString(), "2")
    }

    //MARK:- Testing conversion of numbers

    func testConversionToBiggerBase() {
        num1 = Number(number: "1010.1011", base: .Base2)
        XCTAssertEqual(num1.toString(base: .Base16), "A.B")
    }

    func testConversionToSmallerBase() {
        num1 = Number(number: "1A.8", base: .Base12)
        XCTAssertEqual(num1.toString(base: .Base9), "24.6")
    }
    
    //MARK:- Testing number addition
    
    func testSameBaseWholeAddition() {
        num1 = Number(number: "F", base: .Base16)
        num2 = Number(number: "A", base: .Base16)
        num3 = num1 + num2
        XCTAssertEqual(num3.value, 25)
        XCTAssertFalse(num3.hasFract)
    }
    
    func testDifferentBaseWholeAddition() {
        num1 = Number(number: "50", base: .Base9)
        num2 = Number(number: "100", base: .Base7)
        num3 = num1 + num2
        XCTAssertEqual(num3.value, 94)
        XCTAssertFalse(num3.hasFract)
    }
    
    func testSameBaseFloatingAddition() {
        num1 = Number(number: "101.01", base: .Base2)
        num2 = Number(number: "1.1", base: .Base2)
        num3 = num1 + num2
        XCTAssertEqual(num3.value, 6.75)
        XCTAssertTrue(num3.hasFract)
    }
    
    func testDifferentBaseFloatingAddition() {
        num1 = Number(number: "1200.2", base: .Base5)
        num2 = Number(number: "35.6", base: .Base15)
        num3 = num1 + num2
        XCTAssertEqual(num3.value, 225.8)
        XCTAssertTrue(num3.hasFract)
    }
    
    func testFloatingAdditionThatAddsToWhole() {
        num1 = Number(number: "0.3", base: .Base10)
        num2 = Number(number: "0.7", base: .Base10)
        num3 = num1 + num2
        XCTAssertEqual(num3.value, 1)
        XCTAssertFalse(num3.hasFract)
    }
    
    func testNegativeAddition() {
        num1 = Number(number: "10.5", base: .Base10)
        num2 = Number(number: "-11", base: .Base7)
        num3 = num1 + num2
        XCTAssertEqual(num3.value, 2.5)
        XCTAssertTrue(num3.hasFract)
    }
    
    func testBaseAfterAddition() {
        num1 = Number(number: "1", base: .Base3)
        num2 = Number(number: "F", base: .Base16)
        num3 = num1 + num2
        XCTAssertEqual(num3.base, Base.Base16)
    }
    
    func testAdditionWithPlusEquals() {
        num1 = Number(number: "1.5", base: .Base10)
        num2 = Number(number: "0.5", base: .Base10)
        num2 += num1
        XCTAssertEqual(num2.value, 2)
        XCTAssertFalse(num2.hasFract)
    }
    
    func testAdditionWithPlusEqualsThatAddsToWhole() {
        num1 = Number(number: "1.3", base: .Base10)
        num2 = Number(number: "1.7", base: .Base10)
        num1 += num2
        XCTAssertEqual(num1.value, 3)
        XCTAssertFalse(num1.hasFract)
    }
    
    //MARK:- Testing number subtraction
    
    func testSameBaseWholeSubtraction() {
        num1 = Number(number: "F", base: .Base16)
        num2 = Number(number: "A", base: .Base16)
        num3 = num1 - num2
        XCTAssertEqual(num3.value, 5)
        XCTAssertFalse(num3.hasFract)
    }
    
    func testDifferentBaseWholeSubtraction() {
        num1 = Number(number: "50", base: .Base9)
        num2 = Number(number: "100", base: .Base7)
        num3 = num1 - num2
        XCTAssertEqual(num3.value, -4)
        XCTAssertFalse(num3.hasFract)
    }
    
    func testSameBaseFloatingSubtraction() {
        num1 = Number(number: "101.01", base: .Base2)
        num2 = Number(number: "1.1", base: .Base2)
        num3 = num1 - num2
        XCTAssertEqual(num3.value, 3.75)
        XCTAssertTrue(num3.hasFract)
    }
    
    func testDifferentBaseFloatingSubtraction() {
        num1 = Number(number: "1200.2", base: .Base5)
        num2 = Number(number: "35.6", base: .Base15)
        num3 = num1 - num2
        XCTAssertEqual(num3.value, 125)
        XCTAssertFalse(num3.hasFract)
    }
    
    func testSubtractionThatEndsWithWhole() {
        num1 = Number(number: "1.7", base: .Base10)
        num2 = Number(number: "0.7", base: .Base10)
        num3 = num1 - num2
        XCTAssertEqual(num3.value, 1)
        XCTAssertFalse(num3.hasFract)
    }
    
    func testNegativeSubtraction() {
        num1 = Number(number: "10.5", base: .Base10)
        num2 = Number(number: "-11", base: .Base7)
        num3 = num1 - num2
        XCTAssertEqual(num3.value, 18.5)
        XCTAssertTrue(num3.hasFract)
    }
    
    func testBaseAfterSubtraction() {
        num1 = Number(number: "1", base: .Base3)
        num2 = Number(number: "F", base: .Base16)
        num3 = num1 - num2
        XCTAssertEqual(num3.base, Base.Base16)
    }
    
    func testSubtractionWithMinusEquals() {
        num1 = Number(number: "0.5", base: .Base10)
        num2 = Number(number: "1.5", base: .Base10)
        num2 -= num1
        XCTAssertEqual(num2.value, 1)
        XCTAssertFalse(num2.hasFract)
    }
    
    func testSubtractionWithMinusEqualThatEndsWithWhole() {
        num1 = Number(number: "1.3", base: .Base10)
        num2 = Number(number: "0.3", base: .Base10)
        num1 -= num2
        XCTAssertEqual(num1.value, 1)
        XCTAssertFalse(num1.hasFract)
    }
    
    //MARK:- Testing number multiplication (Double)
    
    func testMultiplicationWithDouble() {
        num1 = Number(number: "0.5", base: .Base10)
        num2 = num1 * 2
        XCTAssertEqual(num2.value, 1)
        XCTAssertFalse(num2.hasFract)
    }
    
    //MARK:- Testing radix complement
    
    func testRadixComplementNoDigits() {
        num1 = Number(number: "124", base: .Base16)
        XCTAssertEqual(num1.radixComplement().toString(), "EDC")
    }
    
    func testRadixComplementWithDigits() {
        num1 = Number(number: "7312", base: .Base10)
        XCTAssertEqual(num1.radixComplement(digits: 6).toString(), "992688")
    }
    
    func testRadixComplementDiminishedNoDigits() {
        num1 = Number(number: "1", base: .Base8)
        XCTAssertEqual(num1.radixComplementDiminished().toString(), "6")
    }
    
    func testRadixComplementDiminishedWithDigits() {
        num1 = Number(number: "1010", base: .Base2)
        XCTAssertEqual(num1.radixComplementDiminished(digits: 8).toString(), "11110101")
    }

}
