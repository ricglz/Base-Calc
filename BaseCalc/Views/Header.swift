//
//  Header.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 30/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct Header: View {
    @EnvironmentObject var layoutState: LayoutState
    
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
    @EnvironmentObject var toastManager: ToastManager
    let generator = UIImpactFeedbackGenerator(style: .light)

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
            .onLongPressGesture(perform: copyToClipboard)
    }

    func copyToClipboard() {
        self.generator.impactOccurred()
        UIPasteboard.general.string = calculatorState.currentText
        toastManager.showToast(content: "Copied to Clipboard")
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .environmentObject(CalculatorState())
            .environmentObject(PopUpPickerViewManager())
            .environmentObject(LayoutState(isLandscape: false))
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}
