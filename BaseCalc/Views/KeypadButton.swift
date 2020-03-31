//
//  KeypadButton.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 30/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct KeypadButton: View {
    let label: String
    let width, height: CGFloat

    @EnvironmentObject var calculatorState: CalculatorState

    var body: some View {
        return createButton()
    }
    
    func createButton() -> AnyView {
        switch label {
        case "AC":
            // orange button
            return AnyView(Button(action: calculatorState.allClear) {
                Text(label)
                    .modifier(OrangeButton(width: width, height: height))
            })
        case "±":
            // orange button
            return AnyView(Button(action: calculatorState.changeSign) {
                Text(label)
                    .modifier(OrangeButton(width: width, height: height))
            })
        case "ß":
            // orange button
            return AnyView(Button(action: {}) {
                Text(label)
                    .modifier(ComplementButton(width: width, height: height, enabled: !calculatorState.isNegative))
            }.disabled(calculatorState.isNegative))
        case "+":
            // sum button
            return AnyView(Button(action: calculatorState.sum) {
                Text(label)
                    .modifier(ArithmeticButton(width: width, height: height, enabled: calculatorState.willPerformArithmetic &&
                    calculatorState.prevOperation == Operation.add))
            })
        case "-":
            // sum button
            return AnyView(Button(action: calculatorState.substract) {
                Text(label)
                    .modifier(ArithmeticButton(width: width, height: height, enabled: calculatorState.willPerformArithmetic &&
                    calculatorState.prevOperation == Operation.subtract))
                })
        case "=":
            // gray button
            return AnyView(Button(action: calculatorState.solve) {
                Text(label)
                    .modifier(GrayButton(width: width, height: height))
            })
        case ".", "0":
            // gray button
            return AnyView(Button(action: addDigit) {
                Text(label)
                    .modifier(GrayButton(width: width, height: height))
            })
        case "X":
            // gray button
            return AnyView(Button(action: {}) {
                Text(label)
                    .modifier(OrangeButton(width: width, height: height))
            })
        default:
            // digit button
            let digits = [
                "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B",
                "C", "D", "E", "F"
            ]
            let enabled = digits.firstIndex(of: label)! < calculatorState.currentBase.rawValue
            return AnyView(Button(action: addDigit) {
                Text(label)
                    .modifier(DigitButton(width: width, height: height, enabled: enabled))
            }.disabled(!enabled))
        }
    }

    func addDigit() {
        calculatorState.addDigit(label)
    }
}
struct KeypadButton_Previews: PreviewProvider {
    static var previews: some View {
        Keypad()
            .environmentObject(CalculatorState())
            .environmentObject(PopUpPickerViewManager())
            .previewLayout(.fixed(width: 400, height: 600))
    }
}
