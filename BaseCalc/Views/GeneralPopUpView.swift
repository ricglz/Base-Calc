//
//  GeneralPopUpView.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 01/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct GeneralPopUpView<Content: View>: View {
    let isShowing: Bool;
    let view: () -> Content;
    let transition: AnyTransition
    let bgColor: Color

    init(bgColor: Color = Color.black,
         transition: AnyTransition = .move(edge: .bottom),
         isShowing: Bool,
         view: @escaping () -> Content
    ) {
        self.isShowing = isShowing
        self.view = view
        self.transition = transition
        self.bgColor = bgColor
    }

    var body: some View {
        ZStack {
            if isShowing {
                bgColor
                     .edgesIgnoringSafeArea(.all)
                     .opacity(0.75)
                view()
                    .transition(transition)
                    .animation(.default)
            }
        }.animation(.default)
    }
}
