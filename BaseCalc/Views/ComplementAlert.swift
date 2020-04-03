//
//  ComplementAlert.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 01/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct ComplementAlert: View {
    @EnvironmentObject var manager: ComplementAlertManager
    @EnvironmentObject var calculatorState: CalculatorState

    var body: some View {
        GeneralPopUpView(
            isShowing: manager.isShowing,
            transition: AnyTransition.scale(scale: 0.95).combined(with: .opacity)
        ) { () -> AnyView in
            AnyView(GeometryReader { geometry in
                VStack {
                    ZStack(alignment: .center){
                        Color.alertBackground
                        ComplementAlertContent(
                            digitValue: String(self.calculatorState.currentText.count)
                        )
                    }
                    .frame(
                        width: geometry.size.width * 0.9,
                        height: 200
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )

                    Spacer()
                        .frame(height: geometry.size.width * 0.75)
                }
            })
        }
    }
}

struct ComplementAlertContent: View {
    @State var digits: String
    let lowerDigitLimit: String

    init(digitValue: String) {
        _digits = State(initialValue: digitValue)
        lowerDigitLimit = digitValue
    }

    var body: some View {
        VStack {
            Text("Radix complement")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            Text("Select digits to compute:")
                .font(.subheadline)
                .foregroundColor(.gray)

            TextField("Digits", text: $digits)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .padding(5)
                .background(Color.pickerviewBackground)
                .foregroundColor(.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.5)
                )

                Text("Enter a value between \(lowerDigitLimit) and 24")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .opacity(isDigitCountValid() ? 0 : 1)

            AlertButtons(
                digits: digits,
                isDigitCountValid: isDigitCountValid()
            )
        }
        .padding(.horizontal)
    }

    func isDigitCountValid() -> Bool {
        Int(self.digits) ?? 0 <= 24 && Int(self.digits) ?? 0 >= Int(self.lowerDigitLimit)!
    }
}

struct AlertButtons: View {
    @EnvironmentObject var manager: ComplementAlertManager
    @EnvironmentObject var calculatorState: CalculatorState

    let digits: String
    let isDigitCountValid: Bool

    var body: some View {
        HStack {
            Button(action: {
                self.manager.isShowing = false
            }){
                Text("Cancel")
                    .accentColor(Color.red)
            }

            Spacer()

            Button(action: {
                let number = Number(number: self.calculatorState.currentText, base: self.calculatorState.currentBase)
                let complement = number.radixComplement(digits: Int(self.digits))
                self.calculatorState.currentText = complement.toString()
                self.manager.isShowing = false
            }){
                Text("ß compl.")
            }.disabled(!isDigitCountValid)

            Spacer()

            Button(action: {
                let number = Number(number: self.calculatorState.currentText, base: self.calculatorState.currentBase)
                let complement = number.radixComplementDiminished(digits: Int(self.digits))
                self.calculatorState.currentText = complement.toString()
                self.manager.isShowing = false
            }){
                Text("ß⁻¹ compl.")
            }.disabled(!isDigitCountValid)

        }
        .padding(.vertical)
    }
}

struct ComplementAlert_Previews: PreviewProvider {
    static var previews: some View {
        ComplementAlert()
            .environmentObject(ComplementAlertManager())
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
