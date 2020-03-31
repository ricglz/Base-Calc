//
//  Keypad.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 30/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct Keypad: View {
    let btnPadding: CGFloat = 6

    let buttons = [
        ["D", "E", "F", "AC"],
        ["A", "B", "C", "±"],
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "ß"],
        ["=", "0", ".", "X"],
    ]

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: self.btnPadding) {
                ForEach(self.buttons, id: \.self) { row in
                    HStack(spacing: self.btnPadding) {
                        ForEach(row, id: \.self) { label in
                            KeypadButton (
                                label: label,
                                width: (geometry.size.width - 5 * self.btnPadding) / 4,
                                height: (geometry.size.height - 7 * self.btnPadding) / 6
                            )
                        }
                    }
                }
            }
        }
    }
}

struct Keypad_Previews: PreviewProvider {
    static var previews: some View {
        Keypad()
            .environmentObject(CalculatorState())
            .environmentObject(PopUpPickerViewManager())
            .previewLayout(.fixed(width: 400, height: 600))
    }
}
