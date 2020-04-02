//
//  PopUpPickerView.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 21/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct PopUpPickerView: View {
    @EnvironmentObject var manager: PopUpPickerViewManager
    
    var body: some View {
        GeneralPopUpView(isShowing: manager.isShowing) { () -> AnyView in
            AnyView(GeometryReader { (geometry) in
                VStack {
                    Spacer()
                    PickerViewWithDoneToolbar().frame(
                        height: geometry.size.height / 2
                    )
                }
                .edgesIgnoringSafeArea(.bottom)
            })
        }
    }
}

struct PickerViewWithDoneToolbar: View {
    var body: some View {
        GeometryReader { (geometry) in
            VStack(spacing: 0) {
                CustomToolbar()
                    .frame(height: geometry.size.height / 6)
                CustomPickerView()
            }
        }
    }
}

struct CustomToolbar: View {
    @EnvironmentObject var manager: PopUpPickerViewManager
    @EnvironmentObject var calculator: CalculatorState
    
    var body: some View {
        ZStack {
            Color.toolbarBackground
            HStack {
                Button(action: hidePopUp) {
                    Text("Done").foregroundColor(Color.blue)
                }.padding(.leading)
                Spacer()
            }
        }
    }
    
    func hidePopUp() {
        let newBase = Base(rawValue: manager.currentIndex + 2)
        let currNumber = Number(number: calculator.currentText, base: calculator.currentBase)
        calculator.currentText = currNumber.toString(base: newBase)
        calculator.currentBase = newBase!
        manager.isShowing = false
    }
}

struct CustomPickerView: View {
    @EnvironmentObject var manager: PopUpPickerViewManager
    
    var body: some View {
        ZStack {
            Color.pickerviewBackground
            HStack {
                Picker("Select base", selection: $manager.currentIndex) {
                    ForEach(2..<17) { (number) in
                        Text("Base \(number)").tag(number)
                    }
                }.labelsHidden()
                 .foregroundColor(Color.white)
            }
        }
    }
}

struct PopUpPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PopUpPickerView()
            .environmentObject(PopUpPickerViewManager())
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
