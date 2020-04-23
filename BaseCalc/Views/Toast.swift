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
                        .background(Color.toastBG)
                        .cornerRadius(10)
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                    .frame(width: geometry.size.width)
                }
                .transition(
                    AnyTransition.move(edge: .top)
                )
                .animation(.default)
                .zIndex(1)
                .onAppear(perform: self.countDownToDissapear)
            } else {
                EmptyView()
            }
        }
    }
    
    /// Wait to later on disappear with animation
    func countDownToDissapear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.manager.isShowing.toggle()
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
