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
        GeneralAlert(isShowing: manager.isShowing) {
            FloatingPointAlertContent(
                number: Number(number: self.calculatorState.currentText, base: self.calculatorState.currentBase)
            )
        }
    }
}

struct FloatingPointAlertContent: View {
    @EnvironmentObject var manager: FloatingPointAlertManager
    @EnvironmentObject var layout: LayoutState
    let single, double: String
    
    init(number: Number) {
        self.single = String(describing: number.getFloatingPoint())
        self.double = String(describing: number.getFloatingPoint(exponentDigits: 11, mantissaDigits: 52))
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Floating Point")
                .font(.headline)
                .foregroundColor(.white)
                .padding()

            if layout.isLandscape {
                HStack {
                    Spacer()
                    
                    Text("Single Precision:")
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text(single)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
            } else {
                VStack {
                    Text("Single Precision:")
                        .bold()
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text(single)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
            }
            
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
            .environmentObject(LayoutState())
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
