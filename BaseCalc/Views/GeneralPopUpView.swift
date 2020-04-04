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
    let bgColor: Color

    init(bgColor: Color = Color.black,
         transition: AnyTransition = .move(edge: .bottom),
         isShowing: Bool,
         Content: @escaping () -> AnyView
    ) {
        self.isShowing = isShowing
        self.Content = Content
        self.transition = transition
        self.bgColor = bgColor
    }

    var body: some View {
        ZStack {
            if isShowing {
                bgColor
                     .edgesIgnoringSafeArea(.all)
                     .opacity(0.75)
                Content()
                .transition(transition)
                .animation(.default)
            }
        }.animation(.default)
    }
}
