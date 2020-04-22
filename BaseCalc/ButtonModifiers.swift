//
//  ButtonModifiers.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 30/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomButton: ViewModifier {
    let width, height: CGFloat
    let mainBG, mainFG, altBG, altFG: Color
    let altCondition: Bool

    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(width: width, height: height)
            .foregroundColor(altCondition ? altFG : mainFG)
            .background(altCondition ? altBG : mainBG)
    }
}

struct LightGrayButton: ViewModifier {
    let width, height: CGFloat
    let altCondition: Bool
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(
                width: width,
                height: height,
                mainBG: .enabledLightGrayBG,
                mainFG: .white,
                altBG: .disabledLightGrayBG,
                altFG: .disabledLightGrayFG,
                altCondition: altCondition
            ))
    }
}

struct DarkGrayButton: ViewModifier {
    let width, height: CGFloat
    let altCondition: Bool
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(
                width: width,
                height: height,
                mainBG: .enabledDarkGrayBG,
                mainFG: .white,
                altBG: .disabledDarkGrayBG,
                altFG: .disabledDarkGrayFG,
                altCondition: altCondition
            ))
    }
}

struct OrangeButton: ViewModifier {
    let width, height: CGFloat
    let altCondition: Bool
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(
                width: width,
                height: height,
                mainBG: .orange,
                mainFG: .white,
                altBG: .white,
                altFG: .orange,
                altCondition: altCondition
            ))
    }
}
