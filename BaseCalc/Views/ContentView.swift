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
            VStack (spacing: 0) {
                Header()
                Keypad()
            }
            PopUpPickerView()
            ComplementAlert()
            FloatingPointAlert()
            Toast()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(CalculatorState())
                .environmentObject(PopUpPickerViewManager())
                .environmentObject(ComplementAlertManager())
                .environmentObject(FloatingPointAlertManager())
                .environmentObject(ToastManager())
                .environmentObject(LayoutState(isLandscape: false))
                .previewLayout(.fixed(width: 320, height: 568))
            
            ContentView()
                .environmentObject(CalculatorState())
                .environmentObject(PopUpPickerViewManager())
                .environmentObject(ComplementAlertManager())
                .environmentObject(FloatingPointAlertManager())
                .environmentObject(ToastManager())
                .environmentObject(LayoutState(isLandscape: true))
                .previewLayout(.fixed(width: 568, height: 320))
        }
    }
}
