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
    var body: some View {
        HStack {
            Spacer()
            Text("0")
                .font(.system(size: 50))
                .foregroundColor(.white)
        }.padding()
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
        let enabled = value() < calculatorState.currentBase.rawValue
        return Button(action: {}) {
            Text(label)
                .font(.title)
                .foregroundColor(enabled ? .white : .gray)
                .frame(width: width,height: height)
                .background(btnColor(enabled))
        }
        .disabled(!enabled)
    }

    func btnColor(_ enabled: Bool) -> Color {
        switch label {
        case "AC", "±", "+", "-", "ß", "X":
            return Color.orange
        default:
            return enabled ? Color.enabledDigit : Color.disabledDigit
        }
    }

    func value() -> Int {
        operationBtns.contains(label) ? 0 : digits.firstIndex(of: label)!
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
