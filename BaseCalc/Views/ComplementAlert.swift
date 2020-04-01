//
//  ComplementAlert.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 01/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct ComplementAlert: View {
    var body: some View {
        ZStack() {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(0.75)
            
            GeometryReader { geometry in
                VStack {
                    ZStack(alignment: .center){
                        Color.alertBackground
                        
                        VStack {
                            AlertBody()
                            AlertButtons()
                        }
                        .padding(.horizontal)
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
            }
        }
    }
}

struct AlertBody: View {
    @State var digits: String = "10"
    
    var body: some View {
        VStack {
            Text("Radix complement")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            
            Text("Select digits to compute:")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            TextField("Digits", text: $digits)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
                .padding(5)
                .background(Color.pickerviewBackground)
                .foregroundColor(.white)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 0.5)
                )
            
            Text("Enter a value between X and XXXX")
                .font(.caption)
                .foregroundColor(Color.gray)
        }
    }
}

struct AlertButtons: View {
    var body: some View {
        HStack {
            Button(action: {}){
                Text("Cancel")
                    .accentColor(Color.red)
            }
            
            Spacer()
            
            Button(action: {}){
                Text("ß compl.")
            }
            
            Spacer()
            
            Button(action: {}){
                Text("ß-1 compl.")
            }
        }
        .padding(.vertical)
    }
}

struct ComplementAlert_Previews: PreviewProvider {
    static var previews: some View {
        ComplementAlert()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
