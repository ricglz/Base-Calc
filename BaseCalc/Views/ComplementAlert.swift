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
        GeneralAlert(isShowing: manager.isShowing) {
            ComplementAlertContent(
                digitValue: String(self.calculatorState.currentText.count)
            )
        }
    }
}

struct ComplementAlertContent: View {
    @EnvironmentObject var layout: LayoutState
    
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
                .padding(.top)

            HStack {
                Text(layout.isLandscape ? "Select digits to compute:" : "Digits:")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                TextField("Digits", text: $digits)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .padding(5)
                    .background(Color.darkLabelBG)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )
            }
            

            Text("Enter a value between \(lowerDigitLimit) and 24")
                .font(.caption)
                .foregroundColor(.gray)
                .opacity(isDigitCountValid() ? 0 : 1)
                .padding(.bottom, 7)

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
                self.manager.isShowing.toggle()
            }){
                Text("Cancel")
                    .accentColor(Color.red)
            }

            Spacer()

            Button(action: {
                self.calculatorState.getRadixComplement(digits: Int(self.digits)!)
                self.manager.isShowing.toggle()
            }){
                Text("ß compl.")
            }.disabled(!isDigitCountValid)

            Spacer()

            Button(action: {
                self.calculatorState.getRadixComplementDiminished(digits: Int(self.digits)!)
                self.manager.isShowing.toggle()
            }){
                Text("ß⁻¹ compl.")
            }.disabled(!isDigitCountValid)

        }
        .padding(.bottom)
    }
}

struct ComplementAlert_Previews: PreviewProvider {
    static var previews: some View {
        ComplementAlert()
            .environmentObject(CalculatorState())
            .environmentObject(LayoutState())
            .environmentObject(ComplementAlertManager(isShowing: true))
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
