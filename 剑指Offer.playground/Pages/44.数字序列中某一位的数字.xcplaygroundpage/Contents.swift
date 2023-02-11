//: [Previous](@previous)

/*:
数字以0123456789101112131415…的格式序列化到一个字符序列中。

在这个序列中，第5位（从下标0开始计数）是5，第13位是1，第19位是4，等等。

请写一个函数，求任意第n位对应的数字。

示例 1：

输入：n = 3
输出：3
示例 2：

输入：n = 11
输出：0

限制：

0 <= n < 2^31
注意：本题与主站 400 题相同：https://leetcode-cn.com/problems/nth-digit/

来源：力扣（LeetCode）

链接：https://leetcode-cn.com/problems/shu-zi-xu-lie-zhong-mou-yi-wei-de-shu-zi-lcof

著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
*/

import Foundation

// 0123456789 1011121314 1516171819 2021222324 25
var num = 21
//num = 100
//num = 11
//num = 14
num = 1000


/**
 2023-02-10
 */
func findNthDigit23210(_ n: Int) -> Int {
    /**
     1、找到位数
     2、找到数字
     3、找到在数字内的下标
     */
    
    /**
     1位 0 ～ 9 = 10 个
     10位 10 ～ 99 = 90 个数字，90 * 2个长度
     100位 100 ～ 999 = 900 个，900 * 3个长度
     
     10 的 n 次方位 有 9 * 10 的 n 次方 个数字
     */
    // 对 n 递减
    
    var n = n
    // 位
    var dig = 1
    // 位长度
    var length = 1
    // 当前位总数字长度
    var digTotalLength = 10
    // 当前位区间起始数字
    var startNum = 0
    
    while n > digTotalLength {
        n -= digTotalLength
        dig *= 10
        length += 1
        startNum = dig
        digTotalLength = 9 * dig * length
    }
    
    // 最后一个能完整显示的数
    let number = startNum + n / length
    let numCharArray = [Character](String(number))
    return Int(String(numCharArray[n % length])) ?? 0
}

findNthDigit23210(num)

/**
 2023-02-09
 */

//func findNthDigit2329(_ n: Int) -> Int {
//    /**
//     0 1 2 3 4 5 6 7 8 9
//     10 11 12 13 14 15 16 17 18 19
//     20 21 ...
//     30 ...
//     40 ...
//     ...
//
//     个位字符 0 ～ 9共： 10 * 1 个
//     十位字符 10 ～ 99共：90 * 2 个
//     百位字符 100 ～ 999共：900 * 3 个
//     千位字符 1000 ～ 9999共：9000 * 4个
//
//     1. 找出 n 所在数字的位 个 十 百。。。
//     2. 找出所在的数字 x
//     3. 找出在数字的第几位
//
//     */
//
//    // 当前位开始的下标
//    var startIndex = 9
//    // 位 1 10 100
//    var dig = 1
//    // 位长度
//    var count = 1
//    var start = 0
//
//    while n > startIndex {
//        if startIndex + 9 * (dig + 1) * (count + 1) > n {
//            dig *= 10
//            count += 1
//            break
//        }
//        else {
//            dig *= 10
//            count += 1
//            startIndex += 9 * dig * count
//        }
//    }
//
//    if count > 1 {
//        start = Int(pow(10, Double(count - 1)))
//    }
//
//    print("\(count)位数字，区间最小：\(start)，当前位起始下标：\(startIndex)")
//
//    var resNum = start
//    // 看是第几个数字
//    while startIndex < n {
//        if startIndex + count < n {
//            startIndex += count
//            resNum += 1
//        }
//        else {
//            break
//        }
//    }
//    print("所在数字：\(resNum)")
//    var resArr: [Character] = Array("\(resNum)")
//
//    // 数字里的第几个字符
//    let offset = n - startIndex - 1
//    print(offset)
//    return Int(String(resArr[offset])) ?? 0
//}

//findNthDigit2329(21)
//findNthDigit2329(200)


func findNthDigit(_ n: Int) -> Int {
    var base: Int = 0
    var index: Int = 0
    
    while index < n {
        let newIndex = index + ((base + 1) * Int(pow(10, Float(base))) * 9)
        if newIndex < n {
            index = newIndex
            base += 1
        }
        else if newIndex == n {
            return 9
        }
        else {
            break
        }
    }

    print("index = \(index)")
    
    // 当前段的起始数字
    let first = Int(pow(10, Float(base)))
    print("1. 当前段的起始数字 = \(first)")
    
    // 每个数字的位数长度
    let length = base + 1
    print("2. 每个数字的位数长度 = \(length)")
    
    // 完整能表示的数量
    let deta = (n - index) / length
    print("3. 完整能表示的数量 = \(deta)")
    
    // 左边第几位
    let left = (n - index) % length
    print("4. 从左边数起第 \(left) 位")
    
    if left == 0 {
        // 目标所在的数字
        let a = first + deta - 1
        print("5. 目标所在的数字 = \(a)")
        
        // 目标位的数字
        let res = a % 10
        print("6. 目标位的数字 = \(res)")
        
        return res
    }
    else {
        // 目标所在的数字
        let a = first + deta
        print("5. 目标所在的数字 = \(a)")
        
        // 目标位的数字
        let res = a / Int(pow(10, Float(length - left))) % 10
        print("6. 目标位的数字 = \(res)")
        return res
    }
}

func findNthDigit2(_ n: Int) -> Int {
    var n = n
    var digit = 1
    var start = 1
    var count = 9
    
    while n > count {
        n -= count
        digit += 1
        start *= 10
        count = digit * start * 9
    }
    
    let num = start + (n - 1) / digit
    let numCharArray = [Character](String(num))
    return Int(String(numCharArray[(n-1) % digit])) ?? 0
}

findNthDigit(num)
findNthDigit2(num)

/**
 0123456789
 1011121314151617181920212223242526272829303132333435363738394041424344454647484950515253545556
 
 */

//: [Next](@next)
