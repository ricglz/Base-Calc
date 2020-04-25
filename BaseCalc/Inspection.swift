//
//  Inspection.swift
//  BaseCalc
//
//  Created by Ricardo J. González on 24/04/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Combine
import SwiftUI

internal final class Inspection<V> where V: View {

    let notice = PassthroughSubject<UInt, Never>()
    var callbacks = [UInt: (V) -> Void]()

    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
