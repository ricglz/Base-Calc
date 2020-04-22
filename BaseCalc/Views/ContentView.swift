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
            ComplementAlert()
            FloatingPointAlert()
            Toast()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CalculatorState())
            .environmentObject(PopUpPickerViewManager())
            .environmentObject(ComplementAlertManager())
            .environmentObject(FloatingPointAlertManager())
            .environmentObject(ToastManager())
            .environmentObject(LayoutState())
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
