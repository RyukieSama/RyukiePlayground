//: [上一题](@previous)

/*:
# 67-把字符串转换成整数

## 题目

写一个函数 StrToInt，实现把字符串转换成整数这个功能。不能使用 atoi 或者其他类似的库函数。

首先，该函数会根据需要丢弃无用的开头空格字符，直到寻找到第一个非空格的字符为止。

当我们寻找到的第一个非空字符为正或者负号时，则将该符号与之后面尽可能多的连续数字组合起来，作为该整数的正负号；假如第一个非空字符是数字，则直接将其与之后连续的数字字符组合起来，形成整数。

该字符串除了有效的整数部分之后也可能会存在多余的字符，这些字符可以被忽略，它们对于函数不应该造成影响。

注意：假如该字符串中的第一个非空格字符不是一个有效整数字符、字符串为空或字符串仅包含空白字符时，则你的函数不需要进行转换。

在任何情况下，若函数不能进行有效的转换时，请返回 0。

## 说明

假设我们的环境只能存储 32 位大小的有符号整数，那么其数值范围为 [−2^31,  2^31 − 1]。如果数值超过这个范围，请返回  INT_MAX (2^31 − 1) 或 INT_MIN (−2^31) 。

## 用例 1

**输入：** "42"

**输出：** 42

## 用例 2

**输入：** "   -42"

**输出：** -42

解释: 第一个非空白字符为 '-', 它是一个负号。
我们尽可能将负号与后面所有连续出现的数字组合起来，最后得到 -42 。

## 用例 3

**输入：** "4193 with words"

**输出：** 4193

解释: 转换截止于数字 '3' ，因为它的下一个字符不为数字。

## 用例 4

**输入：** "words and 987"

**输出：** 0

解释: 第一个非空字符是 'w', 但它不是数字或正、负号。
因此无法执行有效的转换。

## 用例 5

**输入：** "-91283472332"

**输出：** -2147483648

解释: 数字 "-91283472332" 超过 32 位有符号整数范围。
因此返回 INT_MIN (−231) 。

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/ba-zi-fu-chuan-zhuan-huan-cheng-zheng-shu-lcof)
*/
import Foundation

func strToInt20261006(_ str: String) -> Int {
    let strArray = Array(str).map({ String($0) })
    var firstStr: String?, numsArray: [String] = []
    
    for s in strArray {
        if firstStr == nil { // 有效首位
            if s == " " {
                continue
            }
            else if s == "+" || s == "-" {
                firstStr = s
            }
            else if let sVal = Int(s) {
                firstStr = s
                if sVal != 0 {
                    numsArray.append(s)
                }
//                if sVal == 0 {
//                    continue // 不能跳 "0  123" 应该返回0 ，这样写会继续解析
//                }
//                else {
//                    firstStr = s
//                    numsArray.append(s)
//                }
            }
            else {
                break
            }
        }
        else if let sVal = Int(s), let firstStr = firstStr {
            // 注意处理 +000001 情况
            if (firstStr == "+" || firstStr == "-") && numsArray.isEmpty && sVal == 0 {
                continue
            }
            else {
                numsArray.append(s)
            }
        }
        else { // 非法，跳出
            break
        }
    }
    
    let resString = numsArray.joined()
    
    guard numsArray.isEmpty == false else {
        return 0
    }
    
//    guard var resNum = Int64(resString) else {
//        return 0
//    }
    
    // "999999999999999999999999999" numsArray 中只会有数字，因此转换失败意味着超过 Int64
    guard var resNum = Int64(resString) else {
        return firstStr == "-"
            ? Int(Int32.min)
            : Int(Int32.max)
    }
    
    if firstStr == "-" {
        resNum *= -1
    }
    
    let maxValue = Int64(Int32.max)
    let minValue = Int64(Int32.min)

    if resNum > maxValue {
        return Int(Int32.max)
    }

    if resNum < minValue {
        return Int(Int32.min)
    }

    return Int(resNum)
}


func strToInt(_ str: String) -> Int {
    guard str.isEmpty == false else {
        return 0
    }
    let numChars: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let spacer: Character = " ", syb: [Character] = ["-", "+"]
    let chars = Array(str)
    
    
    var res: [Character] = []
    for chr in chars {
        if let _ = res.first { // 有有效的首字符，可以开始拼数字了
            if numChars.contains(chr) {
                res.append(chr) // 存下
            }
            else {
                // 无效字符，截断，直接看结果
                break
            }
        }
        else { // 找第一个非空字符
            if numChars.contains(chr) { // 数字
                res.append(chr)
            }
            else if syb.contains(chr) { // 符号
                res.append(chr)
            }
            else if chr == spacer { // 空格
                continue
            }
            else {
                return 0
            }
        }
    }
    
    return buildInt(String(res))
}

//func buildInt(_ str: String) -> Int {
//    guard let v64 = Int64(str) else {
//        return 0
//    }
//    
//    let min = -(pow(2, 31)), max = pow(2, 31) - 1
//    if v64 > max {
//        return max
//    }
//    else if v64 < min {
//        return min
//    }
//    return v64
//}

func buildInt(_ str: String) -> Int {
    let chars = Array(str)

    guard chars.isEmpty == false else {
        return 0
    }

    var index = 0
    var sign: Int64 = 1

    // 处理正负号
    if chars[index] == "-" {
        sign = -1
        index += 1
    } else if chars[index] == "+" {
        index += 1
    }

    // 字符串只有符号，没有数字
    guard index < chars.count else {
        return 0
    }

    let intMax = Int64(Int32.max)
    let intMin = Int64(Int32.min)

    // 负数允许的绝对值比正数多 1
    let limit = sign > 0 ? intMax : intMax + 1
    var value: Int64 = 0

    while index < chars.count {
        guard let asciiValue = chars[index].asciiValue,
              asciiValue >= Character("0").asciiValue!,
              asciiValue <= Character("9").asciiValue! else {
            break
        }

        let digit = Int64(asciiValue - Character("0").asciiValue!)

        // 在执行 value * 10 + digit 前检查溢出
        if value > (limit - digit) / 10 {
            return sign > 0 ? Int(intMax) : Int(intMin)
        }

        value = value * 10 + digit
        index += 1
    }

    return Int(value * sign)
}
//: [下一题](@next)
