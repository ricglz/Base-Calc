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
    let transition: AnyTransition
    
    init(isShowing: Bool, transition: AnyTransition = .move(edge: .bottom), Content: @escaping () -> AnyView) {
        self.isShowing = isShowing
        self.Content = Content
        self.transition = transition
    }
    
    var body: some View {
        ZStack {
            if isShowing {
                Color.black
                     .edgesIgnoringSafeArea(.all)
                     .opacity(0.75)
                Content()
                .transition(transition)
                .animation(.default)
            }
        }.animation(.default)
    }
}
