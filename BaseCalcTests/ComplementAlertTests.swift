//
//  ComplementAlertTests.swift
//  BaseCalcTests
//
//  Created by Ricardo J. González on 24/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Combine
import XCTest
import SwiftUI
import ViewInspector

@testable import BaseCalc

extension Inspection: InspectionEmissary where V: Inspectable { }

extension ComplementAlert: Inspectable {}
extension ComplementAlertContent: Inspectable {}
extension GeneralAlert: Inspectable {}

class ComplementAlertTests: XCTestCase {
    
    var view : ComplementAlert!
    let type = GeneralPopUpView<GeometryReader<VStack<TupleView<(ModifiedContent<ModifiedContent<ModifiedContent<ZStack<TupleView<(Color, ComplementAlertContent)>>, _FrameLayout>, _ClipEffect<RoundedRectangle>>, _OverlayModifier<_ShapeView<_StrokedShape<RoundedRectangle>, Color>>>, ModifiedContent<Spacer, _FrameLayout>)>>>>.self
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        view = ComplementAlert()
    }
    
    func runViewHosting() {
        let manager = ComplementAlertManager(isShowing: true)
        let state = CalculatorState()
        
        ViewHosting.host(
            view: view.environmentObject(manager).environmentObject(state)
        )
    }
    
    func getViewVstack(_ view: InspectableView<ViewType.View<ComplementAlert>>)
        throws -> InspectableView<ViewType.VStack> {
        try view.view(GeneralAlert<ComplementAlertContent>.self).view(type)
                .zStack().geometryReader(1).vStack().zStack(0)
                .view(ComplementAlertContent.self, 1).vStack()
    }
    
    func testShowsCorrectContent() throws {
        let exp = view.inspection.inspect { view in
            let vstack = try self.getViewVstack(view)
            XCTAssertFalse(vstack.isEmpty)
            let text = try vstack.text(0).string()
            XCTAssertEqual(text, "Radix complement")
            
        }
        runViewHosting()
        wait(for: [exp], timeout: 0.1)
    }

}
