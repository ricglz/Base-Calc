//
//  FloatingPointAlert.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 19/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct FloatingPointAlert: View {
    @EnvironmentObject var calculatorState: CalculatorState
    @EnvironmentObject var manager: FloatingPointAlertManager
    
    var body: some View {
        GeneralPopUpView(
            transition: AnyTransition.scale(scale: 0.95).combined(with: .opacity),
            isShowing: manager.isShowing
        ) { () -> AnyView in
            AnyView(GeometryReader { geometry in
                VStack {
                    ZStack(alignment: .center){
                        Color.alertBackground
                        FloatingPointAlertContent(
                            number: Number(number: self.calculatorState.currentText, base: self.calculatorState.currentBase)
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

struct FloatingPointAlertContent: View {
    @EnvironmentObject var manager: FloatingPointAlertManager
    let single, double: String
    
    init(number: Number) {
        self.single = String(describing: number.getFloatingPoint())
        self.double = String(describing: number.getFloatingPoint(exponentDigits: 11, mantisaDigits: 52))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Floating Point")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            Text("Single Precision:")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(single)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button("Dismiss"){
                self.manager.isShowing.toggle()
            }
            .padding()

        }
        .padding(.horizontal)
    }
}

struct FloatingPointAlert_Previews: PreviewProvider {
    static var previews: some View {
        FloatingPointAlert()
            .environmentObject(CalculatorState())
            .environmentObject(FloatingPointAlertManager(isShowing: true))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
