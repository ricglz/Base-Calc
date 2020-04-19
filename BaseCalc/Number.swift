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

class FloatingPoint: NSObject {
    var signo: String!
    var exp: String!
    var mantisa: String!
    
    init(signo: String, exp: String, mantisa: String){
        self.signo = signo
        self.exp = exp
        self.mantisa = mantisa
    }
    
    override var description: String {
        return "\(signo!) \(exp!) \(mantisa!)"
    }
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

        let digits = Array(num)
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
            self.hasFract = self.value != floor(self.value)

        } else {
            self.value = Double(Int(num, radix: base.rawValue)!)
            self.hasFract = false
        }
    }
    
    //MARK:- Base Conversions

    private func fractToString(_ fract: Double, _ base: Base, _ precision: Int) -> String {
        var fractNum = fract
        let error = 1e-10
        var count = 1

        var result = ""

        while fractNum > error && result.count < precision {
            fractNum *= Double(base.rawValue)
            let wholeFractNum = Int(fractNum)

            result += String(wholeFractNum, radix: base.rawValue, uppercase: true)
            fractNum -= Double(wholeFractNum)
            count += 1
        }

        return result
    }

    func toString(base: Base? = nil, precision: Int = 15) -> String {
        let base = base ?? self.base

        let wholeNum = Int(value)
        let wholeStr = String(wholeNum, radix: base.rawValue, uppercase: true)

        let fractNum = abs(value) - abs(Double(wholeNum))
        let fractStr = hasFract ? "." + fractToString(fractNum, base, precision) : ""

        return wholeStr + fractStr
    }
    
    private func setBase(base: Base) {
        self.base = base
    }
    
    //MARK:- Arithmetic Operations
    
    static func + (leftNum: Number, rightNum: Number) -> Number {
        let sumValue = leftNum.value + rightNum.value
        let newNum = Number(number: String(sumValue), base: .Base10)
        newNum.setBase(base: rightNum.base)
        
        return newNum
    }
    
    static func += (leftNum: inout Number, rightNum: Number) {
        leftNum = leftNum + rightNum
    }
    
    static func - (leftNum: Number, rightNum: Number) -> Number {
        let negNum = rightNum * -1
        return leftNum + negNum
    }
    
    static func -= (leftNum: inout Number, rightNum: Number) {
        leftNum = leftNum - rightNum
    }
    
    static func * (leftNum: Number, rightNum: Double) -> Number {
        let multValue = leftNum.value * rightNum
        let newNum = Number(number: String(multValue), base: .Base10)
        newNum.setBase(base: leftNum.base)
        
        return newNum
    }
    
    static func / (leftNum: Number, rightNum: Double) -> Number {
        return leftNum * (1.0 / rightNum)
    }
    
    //MARK:- Radix Complement
    
    func radixComplement(digits: Int? = nil) -> Number {
        let digits = digits ?? self.toString().count
        let complementNumber = "1" + String(repeating: "0", count: digits)
        
        return Number(number: complementNumber, base: base) - self
    }
    
    func radixComplementDiminished(digits: Int? = nil) -> Number {
        return radixComplement(digits: digits) - Number(number: "1", base: base)
    }
    
    //MARK:- Floating Point Arithmetic
    
    func getFloatingPoint(exponentDigits: Int = 8, mantisaDigits: Int = 23) -> FloatingPoint {
        // Obtain sign
        let s = value >= 0 ? "0" : "1"
        
        // Obtain exponent
        let expBias = pow(2, Double(exponentDigits - 1)) - 1
        let expVal = floor(log2(abs(value)))
        let expPolarized = Int(expBias + expVal)
        let expBinary = String(expPolarized, radix: 2)
        let e = String(repeating: "0", count: exponentDigits - expBinary.count) + expBinary
        
        // Obtain mantisa
        let mantisaVal = (self / pow(2.0, expVal)).toString(base: .Base2, precision: mantisaDigits)
        var m = ""
        
        if let dotIndex = mantisaVal.range(of: ".") {
            let fract = mantisaVal[dotIndex.upperBound...].prefix(mantisaDigits)
            m = String(fract + String(repeating: "0", count: mantisaDigits - fract.count))
        } else {
            m = String(repeating: "0", count: mantisaDigits)
        }
        
        return FloatingPoint(signo: s, exp: e, mantisa: m)
    }
}
