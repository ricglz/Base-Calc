//
//  CalculatorState.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 17/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Foundation
import SwiftUI

class CalculatorState: ObservableObject {
    @Published var currentBase: Base = .Base2
}

class PopUpPickerViewManager: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var currentIndex: Int = 8
    
    init(_ showing: Bool? = nil) {
        isShowing = showing ?? false
    }
    
    func showPickerView(_ currentBase: Base) {
        isShowing = true
        currentIndex = currentBase.rawValue - 2
    }
}
