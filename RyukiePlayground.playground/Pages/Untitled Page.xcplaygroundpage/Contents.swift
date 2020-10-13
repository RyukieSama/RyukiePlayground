//: [Previous](@previous)

import Foundation

extension NSNumber {
    func getDecimalString(maximumFractionDigits : Int) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = NumberFormatter.Style.decimal
        nf.roundingMode = .halfUp
        nf.maximumFractionDigits = maximumFractionDigits
        nf.minimumFractionDigits = maximumFractionDigits
        let persentString = "\(nf.string(from: self) ?? "")"

//        // 四舍五入
//        let nfRound = NumberFormatter()
//        nfRound.numberStyle = NumberFormatter.Style.decimal
//        nfRound.roundingMode = .up
//        nfRound.maximumFractionDigits = maximumFractionDigits
//        nfRound.minimumFractionDigits = maximumFractionDigits
//        let roundString = "\(nfRound.string(from: self) ?? "")"
//
//        guard let roundDouble = Double(roundString) else {
//            return persentString
//        }
//
//        let deta = roundDouble - self.doubleValue
//        if (deta < 0.000_000_000_1 && deta > 0) || (deta < 0 && deta > -0.000_000_000_1) {
//            return roundString
//        }
        
        return persentString
    }
}

var number: NSNumber = 0.5
//number = 0.099_999_999_999_999_99
number.getDecimalString(maximumFractionDigits: 0)

//: [Next](@next)
