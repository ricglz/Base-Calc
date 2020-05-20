//
//  CalculatorState.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 17/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Foundation
import SwiftUI

enum Operation: String {
    case add = "+";
    case subtract = "−";
    case multiply = "×";
    case divide = "÷";
    case and = "AND";
    case or = "OR";
    case xor = "XOR";
    case nor = "NOR";
    case leftShift1 = "<<";
    case leftShiftN = "X<<Y";
    case rightShift1 = ">>";
    case rightShiftN = "X>>Y";
}

class LayoutState: ObservableObject {
    @Published var isLandscape: Bool

    init(isLandscape: Bool = false) {
        self.isLandscape = isLandscape
        
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(self.onRotation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }

    @objc func onRotation() {
        let orientation = UIDevice.current.orientation
        
        if orientation == .portrait || orientation.isLandscape {
            self.isLandscape = orientation.isLandscape
        }
    }
}

class CalculatorState: ObservableObject {
    @Published var currentBase: Base = .Base10
    @Published var prevNumber: Number? = nil
    @Published var prevOperation: Operation? = nil
    @Published var currentText: String = "0"
    @Published var hasDecimalDot: Bool = false
    @Published var willPerformOperation: Bool = false
    @Published var isNegative: Bool = false

    func addDigit(_ digitToAdd: String) {
        let digitToAddIsDot = digitToAdd == "."

        if willPerformOperation {
            if digitToAddIsDot {
                currentText = "0."
            } else {
                currentText = digitToAdd
            }

            willPerformOperation.toggle()
            hasDecimalDot = digitToAddIsDot
            return
        }

        if hasDecimalDot && digitToAddIsDot {
            return
        }

        if currentText == "0" && !digitToAddIsDot {
            currentText = digitToAdd
        } else {
            currentText += digitToAdd
            hasDecimalDot = hasDecimalDot || digitToAddIsDot
        }
    }

    func allClear() {
        currentText = "0"
        hasDecimalDot = false
        willPerformOperation = false
        isNegative = false
        prevOperation = nil
        prevNumber = nil
    }
    
    func enterErrorState() {
        currentText = "Error"
    }

    func isInvalidForBitOperations() -> Bool {
        isNegative || hasDecimalDot
    }

    func performOperation(op: Operation) {
        if prevOperation != nil && !willPerformOperation {
            solve()
        }

        prevOperation = op

        if op == .leftShift1 || op == .rightShift1 {
            solve()
        } else {
            willPerformOperation = true
            do {
                prevNumber = try Number(number: currentText, base: currentBase)
            } catch {
                enterErrorState()
            }
        }
    }
    
    func isOperationSelected(op: Operation) -> Bool {
        willPerformOperation && prevOperation == op
    }

    func changeSign() {
        if currentText != "0" {
            if isNegative {
                currentText.remove(at: currentText.startIndex)
            } else {
                currentText = "-" + currentText
            }
            isNegative.toggle()
        }
    }

    func changeBase(_ newBase: Base) {
        do {
            let currNumber = try Number(number: currentText, base: currentBase)
            currentText = currNumber.toString(base: newBase)
            hasDecimalDot = currNumber.hasFract
            currentBase = newBase
        } catch {
            enterErrorState()
        }
    }
    
    func getFloatingPoint() -> String {
        do {
            let number = try Number(number: currentText, base: currentBase)
            return String(describing: number.getFloatingPoint())
        } catch {
            return "Error: Number is too big"
        }
    }
    
    func getRadixComplement(digits: Int) {
        do {
            let number = try Number(number: currentText, base: currentBase)
            let complement = try number.radixComplement(digits: digits)
            currentText = complement.toString()
        } catch {
            enterErrorState()
        }
    }
    
    func getRadixComplementDiminished(digits: Int) {
        do {
            let number = try Number(number: currentText, base: currentBase)
            let complement = try number.radixComplementDiminished(digits: digits)
            currentText = complement.toString()
        } catch {
            enterErrorState()
        }
    }

    func solve() {
        if prevOperation == nil {
            return
        }
        
        do {
            let currentNumber = try Number(number: currentText, base: currentBase)
            
            if prevNumber == nil  && !(prevOperation! == .leftShift1 || prevOperation! == .rightShift1) {
                enterErrorState()
                return
            }

            switch prevOperation {
            case .add:
                changePrevNumber(answer: try prevNumber! + currentNumber)
            case .subtract:
                changePrevNumber(answer: try prevNumber! - currentNumber)
            case .multiply:
                changePrevNumber(answer: try prevNumber! * currentNumber)
            case .divide:
                changePrevNumber(answer: try prevNumber! / currentNumber)
            case .and:
                changePrevNumber(answer: try prevNumber! & currentNumber)
            case .or:
                changePrevNumber(answer: try prevNumber! | currentNumber)
            case .xor:
                changePrevNumber(answer: try prevNumber! ^ currentNumber)
            case .nor:
                changePrevNumber(answer: try prevNumber! ~| currentNumber)
            case .leftShiftN:
                changePrevNumber(answer: try prevNumber! << currentNumber)
            case .leftShift1:
                changePrevNumber(answer: try currentNumber << Number(number: "1", base: currentBase))
            case .rightShiftN:
                changePrevNumber(answer: try prevNumber! >> currentNumber)
            case .rightShift1:
                changePrevNumber(answer: try currentNumber >> Number(number: "1", base: currentBase))
            default:
                print(prevOperation == nil)
            }
        } catch {
            enterErrorState()
        }
    }

    private func changePrevNumber(answer: Number) {
        prevNumber = answer
        currentText = answer.toString()
        isNegative = answer.value < 0
        prevOperation = nil
    }
}

class GeneralAlertManager: ObservableObject {
    @Published var isShowing: Bool = false

    init(isShowing: Bool = false) {
        self.isShowing = isShowing
    }
}

class PopUpPickerViewManager: GeneralAlertManager {
    @Published var currentIndex: Int = 8

    func showPickerView(_ currentBase: Base) {
        isShowing = true
        currentIndex = currentBase.rawValue - 2
    }
}

class ComplementAlertManager: GeneralAlertManager {}

class FloatingPointAlertManager: GeneralAlertManager {}

class InfoViewManager: GeneralAlertManager {}

class ToastManager: GeneralAlertManager {
    @Published var content: String = ""

    init(isShowing: Bool = false, content: String = "") {
        super.init(isShowing: isShowing)
        self.content = content
    }

    func showToast(content: String) {
        isShowing = true
        self.content = content
    }
}
