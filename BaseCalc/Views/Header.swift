//
//  Header.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 30/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

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
    @EnvironmentObject var toastManager: ToastManager
    let generator = UIImpactFeedbackGenerator(style: .light)

    var body: some View {
        VStack(alignment: .trailing) {
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

            Text(formatBinaryString())
                .font(.system(size: 14, design: .monospaced))
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
    }

    func copyToClipboard() {
        self.generator.impactOccurred()
        UIPasteboard.general.string = calculatorState.currentText
        toastManager.showToast(content: "Copied to Clipboard")
    }

    func formatBinaryString() -> String {
        let num = Number(
            number: calculatorState.currentText,
            base: calculatorState.currentBase
        ).toString(base: .Base2)

        let pad = String(repeating: "0", count: max(32 - num.count, 0))
        var ans = pad + num

        for i in stride(from: ans.count, to: 0, by: -4) {
            let index = ans.index(ans.startIndex, offsetBy: i)
            ans.insert(" ", at: index)
        }

        return ans
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
            .environmentObject(CalculatorState())
            .environmentObject(PopUpPickerViewManager())
            .previewLayout(.sizeThatFits)
    }
}
