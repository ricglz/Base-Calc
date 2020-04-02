//
//  GeneralPopUpView.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 01/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct GeneralPopUpView: View {
    let isShowing: Bool;
    let Content: () -> AnyView;
    
    var body: some View {
        ZStack {
            if isShowing {
                Color.black
                     .edgesIgnoringSafeArea(.all)
                     .opacity(0.75)
                Content()
                .transition(.move(edge: .bottom))
                .animation(.default)
            }
        }.animation(.default)
    }
}
