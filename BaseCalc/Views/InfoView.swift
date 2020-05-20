//
//  InfoView.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 20/05/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Text("Hello World")
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
