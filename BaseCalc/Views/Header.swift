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
    @EnvironmentObject var infoViewManager: InfoViewManager
    
    var body: some View {
        VStack {
            if !layoutState.isLandscape {
                HStack {
                    HeaderBaseLabel()
                    Spacer()
                    Button(action: {
                        self.infoViewManager.isShowing.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }
                    .accentColor(.orange)
                    .sheet(isPresented: $infoViewManager.isShowing) {
                        InfoView()
                    }
                }.padding()
            }
            NumberLabel()
        }
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
    @EnvironmentObject var layoutState: LayoutState
    @EnvironmentObject var toastManager: ToastManager
    @EnvironmentObject var infoViewManager: InfoViewManager
    
    let generator = UIImpactFeedbackGenerator(style: .light)

    var body: some View {
        HStack(alignment: .top) {
            if layoutState.isLandscape {
                Button(action: {
                    self.infoViewManager.isShowing.toggle()
                }) {
                    Image(systemName: "info.circle")
                }
                .accentColor(.orange)
                .sheet(isPresented: $infoViewManager.isShowing) {
                    InfoView()
                }
            }
            Spacer()
            Text(calculatorState.currentText)
                .font(.system(size: 50))
                .foregroundColor(.white)
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(layoutState.isLandscape ? 1 : 0.5)
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
            .environmentObject(InfoViewManager())
            .environmentObject(LayoutState(isLandscape: false))
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}
