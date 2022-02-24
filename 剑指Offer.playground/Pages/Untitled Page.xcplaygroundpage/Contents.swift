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

// 0123456789 1011121314 1516171819 2021222324 25
let num = 10000

findNthDigit(num)
//: [Next](@next)
