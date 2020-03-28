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
    case add; case subtract;
}

class CalculatorState: ObservableObject {
    @Published var currentBase: Base = .Base10
    @Published var prevNumber: Number? = nil
    @Published var prevOperation: Operation? = nil
    @Published var currentText: String = "0"
    @Published var hasDecimalDot: Bool = false
    @Published var willPerformArithmetic: Bool = false
    @Published var isNegative: Bool = false

    func addDigit(_ digitToAdd: String) {
        let digitToAddIsDot = digitToAdd == "."
        
        if willPerformArithmetic {
            prevNumber = Number(number: currentText, base: currentBase)
            
            if digitToAddIsDot {
                currentText = "0."
            } else {
                currentText = digitToAdd
            }
            
            willPerformArithmetic = false
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
        willPerformArithmetic = false
        isNegative = false
        prevOperation = nil
        prevNumber = nil
    }
    
    func changeSign() {
        if currentText != "0" {
            if currentText.prefix(1) == "-" {
                currentText.remove(at: currentText.startIndex)
                isNegative = false
            } else {
                currentText = "-" + currentText
                isNegative = true
            }
        }
    }
    
    func solve() {
        if prevOperation != nil {
            var answer: Number!
            let currentNumber = Number(number: currentText, base: currentBase)
            
            switch prevOperation {
            case .add:
                answer = (prevNumber ?? currentNumber) + currentNumber
            case .subtract:
                answer = (prevNumber ?? currentNumber) - currentNumber
            default:
                print(prevOperation!.rawValue)
            }
            
            prevNumber = answer
            currentText = answer.toString()
            isNegative = answer.value < 0
            prevOperation = nil
        }
    }
}

class PopUpPickerViewManager: ObservableObject {
    @Published var isShowing: Bool = false
    @Published var currentIndex: Int = 8
    
    func showPickerView(_ currentBase: Base) {
        isShowing = true
        currentIndex = currentBase.rawValue - 2
    }
}
