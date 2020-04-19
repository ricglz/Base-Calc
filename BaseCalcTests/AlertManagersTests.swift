//
//  AlertManagersTests.swift
//  BaseCalcTests
//
//  Created by Ricardo J. González on 19/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import XCTest

@testable import BaseCalc

class AlertManagersTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testGeneralAlertManagerBehavior() throws {
        let manager = GeneralAlertManager()
        XCTAssertFalse(manager.isShowing)
    }

    func testPopUpPickerViewManagerShow() throws {
        let manager = PopUpPickerViewManager()
        XCTAssertEqual(manager.currentIndex, 8)
        manager.showPickerView(.Base6)
        XCTAssertTrue(manager.isShowing)
        XCTAssertEqual(manager.currentIndex, 4)
    }

    //MARK:- Toast Manager Aux Function
    func assertEmptyToastManager(manager: ToastManager) {
        XCTAssertFalse(manager.isShowing)
        XCTAssertTrue(manager.content.isEmpty)
    }

    func assertShowingToast(manager: ToastManager, message: String) {
        XCTAssertTrue(manager.isShowing)
        XCTAssertEqual(manager.content, message)
    }

    //MARK:- Toast Manager Tests
    func testToastManagerEmptyConstructor() throws {
        let manager = ToastManager()
        assertEmptyToastManager(manager: manager)
    }

    func testToastManagerFilledConstructor() throws {
        let manager = ToastManager(isShowing: true, content: "Hello!")
        assertShowingToast(manager: manager, message: "Hello!")
    }

    func testToastManagerShowToast() throws {
        let manager = ToastManager()
        assertEmptyToastManager(manager: manager)
        manager.showToast(content: "Well, hello there!")
        assertShowingToast(manager: manager, message: "Well, hello there!")
    }
}
