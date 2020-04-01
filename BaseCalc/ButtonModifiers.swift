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

    func body(content: Content) -> some View {
        content
            .font(.title)
            .frame(width: width, height: height)
    }
}

struct DigitButton: ViewModifier {
    let width, height: CGFloat
    let enabled: Bool
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(width: width, height: height))
            .foregroundColor(enabled ? Color.white : Color.gray)
            .background(enabled ? Color.enabledDigitBG : Color.disabledDigitBG)
    }
}

struct ComplementButton: ViewModifier {
    let width, height: CGFloat
    let enabled: Bool
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(width: width, height: height))
            .foregroundColor(enabled ? Color.white : Color.gray)
            .background(enabled ? Color.orange : Color.disabledOrangeBG)
    }
}

struct ArithmeticButton: ViewModifier {
    let width, height: CGFloat
    let selected: Bool
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(width: width, height: height))
            .foregroundColor(selected ? Color.orange : Color.white)
            .background(selected ? Color.white : Color.orange)
    }
}

struct GrayButton: ViewModifier {
    let width, height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(width: width, height: height))
            .foregroundColor(Color.white)
            .background(Color.enabledDigitBG)
    }
}

struct OrangeButton: ViewModifier {
    let width, height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .modifier(CustomButton(width: width, height: height))
            .foregroundColor(Color.white)
            .background(Color.orange)
    }
}
