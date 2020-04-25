//
//  KeypadButton.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 30/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI
import AVFoundation

struct KeypadButton: View {
    let label: String
    let width, height: CGFloat

    /// UX feedback when clicking
    let systemSoundID: SystemSoundID = 1104
    let generator = UIImpactFeedbackGenerator(style: .light)

    @EnvironmentObject var calculatorState: CalculatorState
    @EnvironmentObject var complementManager: ComplementAlertManager
    @EnvironmentObject var floatingPointManager: FloatingPointAlertManager

    var body: some View {
        return createButton()
    }

    func createButton() -> AnyView {
        switch label {
        case "AC":
            return AnyView(Button(action: generalAction(calculatorState.allClear)) {
                Text(label)
                    .modifier(OrangeButton(width: width, height: height, altCondition: false))
            })
        case "±":
            return AnyView(Button(action: generalAction(calculatorState.changeSign)) {
                Text(label)
                    .modifier(OrangeButton(width: width, height: height, altCondition: false))
            })
        case "ß":
            let disabled = calculatorState.isNegative || calculatorState.hasDecimalDot
            return AnyView(Button(action: generalAction({
                self.complementManager.isShowing.toggle()
            })) {
                Text(label)
                    .modifier(DarkGrayButton(width: width, height: height, altCondition: disabled))
            }.disabled(calculatorState.isNegative))
        case "+":
            let selected = calculatorState.willPerformArithmetic && calculatorState.prevOperation == Operation.add
            return AnyView(Button(action: generalAction(calculatorState.sum)) {
                Text(label)
                    .modifier(OrangeButton(width: width, height: height, altCondition: selected))
            })
        case "-":
            let selected = calculatorState.willPerformArithmetic && calculatorState.prevOperation == Operation.subtract
            return AnyView(Button(action: generalAction(calculatorState.subtract)) {
                Text(label)
                    .modifier(OrangeButton(width: width, height: height, altCondition: selected))
                })
        case "=":
            return AnyView(Button(action: generalAction(calculatorState.solve)) {
                Text(label)
                    .modifier(LightGrayButton(width: width, height: height, altCondition: false))
            })
        case ".", "0":
            return AnyView(Button(action: generalAction(addDigit)) {
                Text(label)
                    .modifier(LightGrayButton(width: width, height: height, altCondition: false))
            })
        case "FP":
            return AnyView(Button(action: generalAction({
                self.floatingPointManager.isShowing.toggle()
            })) {
                Text(label)
                    .modifier(DarkGrayButton(width: width, height: height, altCondition: false))
            })
        default:
            let digits = [
                "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B",
                "C", "D", "E", "F"
            ]
            let disabled = digits.firstIndex(of: label)! >= calculatorState.currentBase.rawValue
            return AnyView(Button(action: generalAction(addDigit)) {
                Text(label)
                    .modifier(LightGrayButton(width: width, height: height, altCondition: disabled))
            }.disabled(disabled))
        }
    }

    func generalAction(_ callback: @escaping () -> Void) -> () -> Void {
        return {
            AudioServicesPlaySystemSound(self.systemSoundID)
            self.generator.impactOccurred()
            callback()
        }
    }

    func addDigit() {
        calculatorState.addDigit(label)
    }
}
struct KeypadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeypadButton(label: "AC", width: 64, height: 64)
            .environmentObject(CalculatorState())
            .environmentObject(PopUpPickerViewManager())
            .previewLayout(.sizeThatFits)
    }
}
