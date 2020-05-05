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
    @EnvironmentObject var baseManager: PopUpPickerViewManager
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
        case "+", "-", "x", "÷":
            return makeArithmeticButton(op: Operation(rawValue: label)!)
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
        case "AND", "OR", "XOR", "NOR":
            return makeBitwiseButton(op: Operation(rawValue: label)!)
        case ">>", "<<", "X>>Y", "X<<Y":
            let disabled = calculatorState.isInvalidForBitOperations()
            return AnyView(Button(action: generalAction({})) {
                Text(label)
                    .modifier(DarkGrayButton(width: width, height: height, altCondition: disabled))
            }.disabled(disabled))
        case "ß":
            let disabled = calculatorState.isInvalidForBitOperations()
            return AnyView(Button(action: generalAction({
                self.complementManager.isShowing = true
            })) {
                Text(label)
                    .modifier(DarkGrayButton(width: width, height: height, altCondition: disabled))
            }.disabled(disabled))
        case "FP":
            return AnyView(Button(action: generalAction({
                self.floatingPointManager.isShowing = true
            })) {
                Text(label)
                    .modifier(DarkGrayButton(width: width, height: height, altCondition: false))
            })
        case "BASE":
            return AnyView(Button(action: generalAction({
                self.baseManager.showPickerView(
                    self.calculatorState.currentBase
                )
            })) {
                Text(label + " \(calculatorState.currentBase.rawValue)")
                    .modifier(DarkGrayButton(width: width * 2 + 6, height: height, altCondition: false))
            })
        default:
            return makeDigitButton(label: label)
        }
    }
    
    func makeArithmeticButton(op: Operation) -> AnyView {
        let selected = calculatorState.isOperationSelected(op: op)
        let callback = { self.calculatorState.performOperation(op: op) }
        return AnyView(Button(action: generalAction(callback)) {
            Text(label)
                .modifier(OrangeButton(width: width, height: height, altCondition: selected))
        })
    }
    
    func makeBitwiseButton(op: Operation) -> AnyView {
        let highlighted = calculatorState.isOperationSelected(op: op)
        let disabled = calculatorState.isInvalidForBitOperations()

        let callback = { self.calculatorState.performOperation(op: op) }
        return AnyView(Button(action: generalAction(callback)) {
            Text(label)
                .modifier(HighlightableDarkGrayButton(width: width, height: height, disabled: disabled, highlighted: highlighted))
        }.disabled(disabled))
    }

    func makeDigitButton(label: String) -> AnyView {
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
            .environmentObject(ComplementAlertManager())
            .environmentObject(FloatingPointAlertManager())
            .previewLayout(.sizeThatFits)
    }
}
