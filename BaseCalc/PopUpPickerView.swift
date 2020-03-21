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
        ZStack {
            if manager.isShowing {
                Color.black
                     .edgesIgnoringSafeArea(.all)
                     .opacity(0.5)
                GeometryReader { (geometry) in
                    VStack {
                        Spacer()
                        PickerViewWithDoneToolbar().frame(
                            height: geometry.size.height / 2
                        )
                    }
                }
            }
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
    
    var body: some View {
        ZStack {
            Color.toolbarBackground
            HStack {
                Button(action: {}) {
                    Text("Done").foregroundColor(Color.blue)
                }.padding(.leading)
                Spacer()
            }
        }
    }
    
    
}

struct CustomPickerView: View {
    @State var currentNumber = 0
    
    var body: some View {
        ZStack {
            Color.pickerviewBackground
            HStack {
                Picker("", selection: $currentNumber) {
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
            .environmentObject(PopUpPickerViewManager(true))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}