//: [Previous](@previous)

import Foundation

var str = "zhao shang y ji".replacingOccurrences(of: " ", with: "")
//var str = "zhao shang y ji"

let string = str.qqtrimToGBKLength(16)

extension String {
    public func qqtrimToGBKLength(_ maxLen: Int) -> String {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let gbkData = (self as NSString).data(using: encoding)!
        let gbkBytes = [UInt8](gbkData)
        if maxLen >= gbkBytes.count {
            return self
        } else if maxLen < 1 {
            return ""
        } else {
            if let str = NSString(data: gbkData[0..<maxLen], encoding: encoding) {
                return str as String
            } else if let str = NSString(data: gbkData[0..<maxLen - 1], encoding: encoding) {
                return str as String
            } else {
                return ""
            }
        }
    }

}

//: [Next](@next)


