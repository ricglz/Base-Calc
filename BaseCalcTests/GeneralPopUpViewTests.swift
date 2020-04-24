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
    
    private func generalContent() -> AnyView {
        AnyView(Text("Hello World!"))
    }
    
    // MARK:- Shows Content Tests
    
    func testIsShowingContent() throws {
        let view = GeneralPopUpView(isShowing: true, Content: generalContent)
        let zStack = try view.inspect().zStack()
        XCTAssertFalse(zStack.isEmpty)
        let content = try zStack.anyView(1).text().string()
        XCTAssertEqual(content, "Hello World!")
    }
    
    func testIsNotShowingContent() throws {
        let view = GeneralPopUpView(isShowing: false, Content: generalContent)
        let zStack = try view.inspect().zStack()
        XCTAssertTrue(zStack.isEmpty)
    }
}
