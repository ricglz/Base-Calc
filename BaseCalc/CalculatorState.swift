//
//  CalculatorState.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 17/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Foundation
import SwiftUI

enum Base: Int {
    case Base2 = 2; case Base3; case Base4; case Base5;
    case Base6; case Base7; case Base8; case Base9;
    case Base10; case Base11; case Base12; case Base13;
    case Base14; case Base15; case Base16;
}

class CalculatorState: ObservableObject {
    @Published var currentBase: Base = .Base2
}
