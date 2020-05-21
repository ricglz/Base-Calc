//
//  InfoView.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 20/05/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var manager: InfoViewManager
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: { self.manager.isShowing.toggle() }) {
                        Text("Close")
                            .bold()
                            .foregroundColor(.orange)
                            .padding()
                    }
                }
                    
                Text("Tips")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.orange)
                
                CardRoulette()
                Spacer()
                    
            }
        }
    }
}

struct CardRoulette: View {
    let cardTexts = [
        ["Landscape", "Rotating to landscape reveals advanced functionalities."],
        ["Disabling", "Some functions only work with integer and positive numbers."],
        ["FP Button", "Displays binary representation of floating number."],
        ["ß Button", "Opens pop-up to calculate radix complement."],
        ["Radix opt.", "Use ß compl. for normal radix. Use ß⁻¹ compl. option for diminished."],
    ]
    let cardWidth: CGFloat = 200
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<self.cardTexts.count) { index in
                        GeometryReader { geo in
                            TipCard(
                                title: self.cardTexts[index][0],
                                description: self.cardTexts[index][1],
                                viewGeo: fullView,
                                cardGeo: geo
                            )
                        }
                        .frame(width: self.cardWidth)
                    }
                }
                .padding(.horizontal, (fullView.size.width - self.cardWidth) / 2)
            }
        }
    }
}

struct TipCard: View {
    let title: String
    let description: String
    let viewGeo: GeometryProxy
    let cardGeo: GeometryProxy
    
    let rotateFactor = 10.0
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding()
            
            Text(description)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(
            width: cardGeo.size.width,
            height: cardGeo.size.height * 0.75
        )
        .background(Color.darkLabelBG)
        .cornerRadius(10)
        .rotation3DEffect(
            .degrees(
                -Double(cardGeo.frame(in: .global).midX - viewGeo.size.width / 2) / rotateFactor
            ),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
            .environmentObject(InfoViewManager())
    }
}
