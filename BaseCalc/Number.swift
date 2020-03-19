//
//  Number.swift
//  BaseCalc
//
//  Created by Juan Lizarraga on 19/03/20.
//  Copyright © 2020 The Senate. All rights reserved.
//

import Foundation

enum Base: Int {
    case Base2 = 2; case Base3; case Base4; case Base5;
    case Base6; case Base7; case Base8; case Base9;
    case Base10; case Base11; case Base12; case Base13;
    case Base14; case Base15; case Base16;
}

class Number: NSObject {
    var value: Double
    var base: Base
    var hasFract: Bool

    init(number: String, base: Base){
        self.base = base
        var num = number

        if num.last == "." {
            num = String(num.dropLast())
        }

        var digits = Array(num)
        let sign = digits[0] == "-" ? -1.0 : 1.0

        // Check if hasFract
        if let dotPos = digits.lastIndex(of: ".") {
            let wholeStr = String(digits[0..<dotPos])
            let fractStr = String(digits[(dotPos+1)...])

            // Calculate Fract Denominator
            let fractNum = Int(fractStr, radix: base.rawValue)!
            let fractDiv = "1" + String(repeating: "0", count: fractStr.count)
            let fractDen = Int(fractDiv, radix: base.rawValue)!
            
            // Combine Whole and Fract
            let wholeVal = Int(wholeStr, radix: base.rawValue)!
            let fractVal = Double(fractNum) / Double(fractDen)
            self.value = (abs(Double(wholeVal)) + fractVal) * sign
            self.hasFract = true

        } else {
            self.value = Double(Int(num, radix: base.rawValue)!)
            self.hasFract = false
        }
    }

    private func fractToString(_ fract: Double, _ base: Base) -> String {
        var fractNum = fract
        let error = 1e-10
        var count = 1

        var result = ""

        while fractNum > error && result.count < 15 {
            fractNum *= Double(base.rawValue)
            let wholeFractNum = Int(fractNum)

            result += String(wholeFractNum, radix: base.rawValue, uppercase: true)
            fractNum -= Double(wholeFractNum)
            count += 1
        }

        return result
    }

    func toString(base: Base? = nil) -> String {
        let base = base ?? self.base

        let wholeNum = Int(value)
        let wholeStr = String(wholeNum, radix: base.rawValue, uppercase: true)

        let fractNum = abs(value) - abs(Double(wholeNum))
        let fractStr = hasFract ? "." + fractToString(fractNum, base) : ""

        return wholeStr + fractStr
    }
}
