//
//  Extensions.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 21/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    // Foreground Colors
    static let disabledLightGrayFG = Color(red: 0.57, green: 0.57, blue: 0.57)
    static let disabledDarkGrayFG = Color(red: 0.37, green: 0.37, blue: 0.37)
    
    // Background Colors
    static let enabledLightGrayBG = Color(red: 0.63, green: 0.63, blue: 0.63)
    static let disabledLightGrayBG = Color(red: 0.39, green: 0.39, blue: 0.39)
    static let enabledDarkGrayBG = Color(red: 0.24, green: 0.24, blue: 0.24)
    static let disabledDarkGrayBG = Color(red: 0.13, green: 0.13, blue: 0.13)
    
    // PopUp Colors
    static let toolbarBG = Color(red: 0.2, green: 0.2, blue: 0.2)
    static let pickerviewBG = Color(red: 0.15, green: 0.15, blue: 0.15)
    static let alertBG = Color(red: 0.10, green: 0.10, blue: 0.10)
    static let toastBG = Color.enabledDarkGrayBG
    static let darkLabelBG = Color.pickerviewBG
}
