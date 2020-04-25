//
//  GeneralAlertViewTests.swift
//  BaseCalcTests
//
//  Created by Ricardo J. González on 23/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import XCTest
import SwiftUI
import ViewInspector

@testable import BaseCalc

extension GeneralPopUpView: Inspectable {}

class GeneralPopUpViewTests: XCTestCase {
    
    // MARK:- Helper functions
    
    private func generalContent() -> some View {
        Text("Hello World!")
    }
    
    // MARK:- Shows Content Tests
    
    func testIsShowingContent() throws {
        let view = GeneralPopUpView(isShowing: true, view: generalContent)
        let zStack = try view.inspect().zStack()
        XCTAssertFalse(zStack.isEmpty)
        let content = try zStack.text(1).string()
        XCTAssertEqual(content, "Hello World!")
    }
    
    func testIsNotShowingContent() throws {
        let view = GeneralPopUpView(isShowing: false, view: generalContent)
        let zStack = try view.inspect().zStack()
        XCTAssertTrue(zStack.isEmpty)
    }
}
