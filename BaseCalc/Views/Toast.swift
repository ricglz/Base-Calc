//
//  Toast.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 04/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct Toast: View {
    @EnvironmentObject var manager: ToastManager
    
    var body: some View {
        Group {
            if manager.isShowing {
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            Text(self.manager.content)
                                .padding(.horizontal)
                                .padding(.vertical, 7.5)
                                .foregroundColor(.white)
                            Spacer()
                        }
                            .frame(width: geometry.size.width * 0.75)
                            .background(Color.disabledDigitBG)
                    .cornerRadius(15)
                    }.padding(.top, 40)
                        .frame(width: geometry.size.width)
                        .transition(
                            AnyTransition.scale(scale: 0.75)
                                .combined(with: .opacity)
                                .combined(with: .slide)
                        )
                        .animation(.default)
                        .onAppear(perform: self.countDownToDissapear)
                }
            } else {
                EmptyView()
            }
        }
    }
    
    /// Wait to later on dissapear with animation
    func countDownToDissapear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          withAnimation {
            self.manager.isShowing = false
          }
        }
    }
}

struct Toast_Previews: PreviewProvider {
    static var previews: some View {
        Toast()
            .environmentObject(ToastManager(isShowing: true, content: "Copied to Clipboard"))
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
