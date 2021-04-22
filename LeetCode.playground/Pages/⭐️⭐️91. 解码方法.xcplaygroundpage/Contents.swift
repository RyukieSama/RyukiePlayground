//: [Previous](@previous)

import Foundation

/*:
 一条包含字母 A-Z 的消息通过以下映射进行了 编码 ：
 
 'A' -> 1
 'B' -> 2
 ...
 'Z' -> 26
 要 解码 已编码的消息，所有数字必须基于上述映射的方法，反向映射回字母（可能有多种方法）。例如，"11106" 可以映射为：
 
 "AAJF" ，将消息分组为 (1 1 10 6)
 "KJF" ，将消息分组为 (11 10 6)
 注意，消息不能分组为  (1 11 06) ，因为 "06" 不能映射为 "F" ，这是由于 "6" 和 "06" 在映射中并不等价。
 
 给你一个只含数字的 非空 字符串 s ，请计算并返回 解码 方法的 总数 。
 
 题目数据保证答案肯定是一个 32 位 的整数。
 
  
 
 示例 1：
 
 输入：s = "12"
 输出：2
 解释：它可以解码为 "AB"（1 2）或者 "L"（12）。
 示例 2：
 
 输入：s = "226"
 输出：3
 解释：它可以解码为 "BZ" (2 26), "VF" (22 6), 或者 "BBF" (2 2 6) 。
 示例 3：
 
 输入：s = "0"
 输出：0
 解释：没有字符映射到以 0 开头的数字。
 含有 0 的有效映射是 'J' -> "10" 和 'T'-> "20" 。
 由于没有字符，因此没有有效的方法对此进行解码，因为所有数字都需要映射。
 示例 4：
 
 输入：s = "06"
 输出：0
 解释："06" 不能映射到 "F" ，因为字符串含有前导 0（"6" 和 "06" 在映射中并不等价）。
  
 
 提示：
 
 1 <= s.length <= 100
 s 只包含数字，并且可能包含前导零。
 
 链接：https://leetcode-cn.com/problems/decode-ways
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

var str = "2101"

//func numDecodingsError(_ s: String) -> Int {
//    if s.first == "0" {
//        print("前导0")
//        return 0
//    }
//
//    var count = 0
//
//    // 下一步有三种结果：卡死 = 0、一步 = 1、 两步 = 2
//    var currentIndex = 0
//    let nsString = NSString(string: s)
//    while currentIndex < s.count - 1 {
//        guard
//            let currentValue = Int(String(nsString.substring(with: NSRange(location: currentIndex, length: 1)))),
//            let nextValue = Int(String(nsString.substring(with: NSRange(location: currentIndex + 1, length: 1))))
//        else {
//            print("error")
//            return 0
//        }
//
//        print("\(currentValue)-\(nextValue)")
//
//        let dv = currentValue * 10 + nextValue
//
//        if dv > 26 {
//            if nextValue == 0 {
//                print(" > 26 && nextValue == 0")
//                return 0
//            }
//            else {
//                count += 2
//            }
//        }
//        else {
//            if (currentValue == 0 && nextValue != 0)
//                ||
//                (currentValue != 0 && nextValue == 0) {
//                count += 1
//            }
//            else if currentValue != 0 && nextValue != 0 {
//                count += (currentValue == s.count - 2 ? 2 : 1)
//            }
//            else {
//                print("00")
//                return 0
//            }
//        }
//        currentIndex += 1
//    }
//
//    return count
//}

func numDecodings(_ s: String) -> Int {
    let nums = s.map { Int(String($0)) ?? 0 }
    guard nums.first != 0 && !nums.isEmpty else { return 0 }
    if nums.count == 1 {
        return 1
    }
    /// 到index = current -2位有多少种
    var dpa = 1
    /// 到index = current -1位有多少种
    var dpb = 1
    
    var count = 0
    
    for index in 1..<nums.count {
        let number = nums[index-1]*10 + nums[index]
        if number == 0 || (number > 20 && number % 10 == 0){
            //字符串违法,不能出现两个零和x0 x > 2
            return 0
        }
        else if number == 10 || number == 20 {
            /**
             -  -2  -1   i  -  -
             X  X   1   0 X X
             10 不可拆分：为到-2位的数量
             */
            count = dpa
            dpb = dpa
        }
        else if number > 26 {
            /**
             -  -2  -1  i   -   -
             X X    2  7  X  X
            必须拆分：为到-1位的数量
             */
            count = dpb
            dpa = count
        }
        else if nums[index-1] == 0 {
            /**
             -  -2  -1  i   -   -
             X X    0  N  X  X
            必须拆分：为到-1位的数量
             */
            count = dpb
            dpa = count
        }
        else if number <= 26{
            // 可分的
            count = dpa + dpb
            dpa = dpb
            dpb = count
        }
    }
    return count
}

numDecodings(str)

//: [Next](@next)
