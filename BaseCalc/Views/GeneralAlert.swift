//
//  GeneralAlert.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 19/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct GeneralAlert<Content: View>: View {
    let Content: () -> Content
    let isShowing: Bool
    
    init(isShowing: Bool, Content: @escaping () -> Content) {
        self.isShowing = isShowing
        self.Content = Content
    }
    
    var body: some View {
        GeneralPopUpView(
            transition: AnyTransition.scale(scale: 0.95).combined(with: .opacity),
            isShowing: isShowing
        ) {
            GeometryReader { geometry in
                VStack {
                    ZStack(alignment: .center){
                        Color.alertBG
                        self.Content()
                    }
                    .frame(
                        width: geometry.size.width * 0.9,
                        height: 150
                    )
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.5)
                    )

                    Spacer()
                        .frame(height: geometry.size.height * 0.5)
                }
            }
        }
    }
}
