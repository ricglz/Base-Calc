//
//  Keypad.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 30/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct Keypad: View {
    @EnvironmentObject var layoutState: LayoutState

    var body: some View {
        ZStack {
            if layoutState.isLandscape {
                LandscapeKeypad()
            } else {
                PortraitKeypad()
            }
        }
    }
}

func createKeypad(buttons: [[String]], width: CGFloat, height: CGFloat, pad: CGFloat) -> some View {
    return VStack(spacing: pad) {
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: pad) {
                    ForEach(row, id: \.self) { label in
                        KeypadButton (label: label, width: width,height: height)
                    }
                }
            }
        }
}

func getDimension(dim: CGFloat, elem: Int, pad: CGFloat) -> CGFloat {
    let padSpace = CGFloat(elem+1) * pad
    let btnSpace = dim - padSpace
    let btnDim = btnSpace / CGFloat(elem)
    return btnDim
}

struct KeypadSection: View {
    let btnPadding: CGFloat = 6
    let buttons: [[String]]
    
    var body: some View {
        GeometryReader { geometry in
            createKeypad(
                buttons: self.buttons,
                width: getDimension(dim: geometry.size.width, elem: self.buttons[0].count, pad: self.btnPadding),
                height: getDimension(dim: geometry.size.height, elem: self.buttons.count, pad: self.btnPadding),
                pad: self.btnPadding
            )
        }
    }
}

struct PortraitKeypad: View {
    var body: some View {
        KeypadSection(
            buttons: [
                ["D", "E", "F", "AC"],
                ["A", "B", "C", "±"],
                ["7", "8", "9", "+"],
                ["4", "5", "6", "-"],
                ["1", "2", "3", "x"],
                ["=", "0", ".", "÷"],
            ]
        )
    }
}

struct LandscapeKeypad: View {
    var body: some View {
        KeypadSection(
            buttons: [
                ["AND", "NOR", "D", "E", "F", "AC"],
                ["OR", "XOR", "A", "B", "C", "±"],
                [">>", "X>>Y", "7", "8", "9", "+"],
                ["<<", "X<<Y", "4", "5", "6", "-"],
                ["FP", "ß", "1", "2", "3", "x"],
                ["BASE", "=", "0", ".", "÷"],
            ]
        )
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Keypad()
                .environmentObject(CalculatorState())
                .environmentObject(PopUpPickerViewManager())
                .environmentObject(LayoutState(isLandscape: false))
                .previewLayout(.fixed(width: 400, height: 600))
            
            Keypad()
                .environmentObject(CalculatorState())
                .environmentObject(PopUpPickerViewManager())
                .environmentObject(LayoutState(isLandscape: true))
                .previewLayout(.fixed(width: 600, height: 400))
        }
        .background(Color.black)
    }
}
