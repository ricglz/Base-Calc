//
//  ContentView.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 15/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Header()
                Spacer()
                NumberLabel()
                Keypad()
            }
            PopUpPickerView()
        }
    }
}

struct Header: View {
    var body: some View {
        HStack {
            HeaderBaseLabel()
            Spacer()
            Button(action: {}) {
                Image(systemName: "info.circle")
            }
            .accentColor(.orange)
        }.padding()
    }
}

struct HeaderBaseLabel: View {
    @EnvironmentObject var calculatorState: CalculatorState
    @EnvironmentObject var manager: PopUpPickerViewManager

    var body: some View {
        Button(action: {
            self.manager.showPickerView(
                self.calculatorState.currentBase
            )
        }) {
            Text("BASE \(calculatorState.currentBase.rawValue)")
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .background(Color.orange)
        }
        .accentColor(.black)
    }
    
}

struct NumberLabel: View {
    @EnvironmentObject var calculatorState: CalculatorState

    var body: some View {
        HStack {
            Spacer()
            Text(calculatorState.currentText)
                .font(.system(size: 50))
                .foregroundColor(.white)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.5)
        }.padding().frame(minHeight: 92)
    }
}

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

struct KeypadButton: View {
    let label: String
    let width, height: CGFloat
    let operationBtns = ["AC", "±", "+", "-", "ß", "=", ".", "X"]
    let digits = [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B",
        "C", "D", "E", "F"
    ]

    @EnvironmentObject var calculatorState: CalculatorState

    var body: some View {
        let isAnOperationBtn = operationBtns.contains(label)
        let enabled = isButtonEnabled(isAnOperationBtn)
        return Button(action: btnAction(isAnOperationBtn)) {
            Text(label)
                .font(.title)
                .frame(width: width,height: height)
                .foregroundColor(btnForegroundColor(enabled))
                .background(btnBackgroundColor(enabled))
        }
        .disabled(!enabled)
    }

    func btnBackgroundColor(_ enabled: Bool) -> Color {
        let willAdd = calculatorState.willPerformArithmetic &&
            calculatorState.prevOperation == Operation.add
        
        let willSubtract = calculatorState.willPerformArithmetic &&
            calculatorState.prevOperation == Operation.subtract
        
        switch label {
        case "+":
            return willAdd ? .white : .orange
        case "-":
            return willSubtract  ? .white : .orange
        case "ß":
            return calculatorState.isNegative ? .disabledOrange : .orange
        case "AC", "±", "X":
            return Color.orange
        default:
            return enabled ? .enabledDigit : .disabledDigit
        }
    }
    
    func btnForegroundColor(_ enabled: Bool) -> Color {
        let willAdd = calculatorState.willPerformArithmetic &&
            calculatorState.prevOperation == Operation.add
        
        let willSubtract = calculatorState.willPerformArithmetic &&
            calculatorState.prevOperation == Operation.subtract
        
        switch label {
        case "+":
            return willAdd ? .orange : .white
        case "-":
            return willSubtract ? .orange : .white
        case "ß":
            return calculatorState.isNegative ? .gray : .white
        case "AC", "±", "X":
            return .white
        default:
            return enabled ? .white : .gray
        }
    }

    func btnAction(_ isAnOperationBtn: Bool) -> () -> Void {
        isAnOperationBtn ? operationAction() : addDigit
    }

    func operationAction() -> () -> Void {
        switch label {
        case "AC":
            return calculatorState.allClear
        case "±":
            return calculatorState.changeSign
        case "+":
            return sum
        case "-":
            return substract
        case "ß":
            return baseComplement
        case "=":
            return calculatorState.solve
        case ".":
            return addDigit
        default:
            return { print(self.label) }
        }
    }

    func addDigit() {
        calculatorState.addDigit(label)
    }

    func sum() {
        calculatorState.willPerformArithmetic = true
        calculatorState.prevOperation = .add
    }

    func substract() {
        calculatorState.willPerformArithmetic = true
        calculatorState.prevOperation = .subtract
    }

    func baseComplement() {
        print("Performing base complement")
    }

    func solve() {
        print("Solving problem")
    }
    
    func isButtonEnabled(_ isAnOperationBtn: Bool) -> Bool {
        if !isAnOperationBtn {
            return digits.firstIndex(of: label)! < calculatorState.currentBase.rawValue
        } else if label == "ß" {
            return !calculatorState.isNegative
        }
        
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//         ContentView().environmentObject(CalculatorState())
//            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))
//        ContentView().environmentObject(CalculatorState()).
//            previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        ContentView()
            .environmentObject(CalculatorState())
            .environmentObject(PopUpPickerViewManager())
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
