//: [Previous](@previous)

/*:
输入一个非负整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。

示例 1:

输入: [10,2]
输出: "102"
示例 2:

输入: [3,30,34,5,9]
输出: "3033459"
 

提示:

0 < nums.length <= 100
说明:

输出结果可能非常大，所以你需要返回一个字符串而不是整数
拼接起来的数字可能会有前导 0，最后结果不需要去掉前导 0


来源：力扣（LeetCode）
 
链接：https://leetcode-cn.com/problems/ba-shu-zu-pai-cheng-zui-xiao-de-shu-lcof

 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

// 优先队列
func minNumber(_ nums: [Int]) -> String {
    var queue = SwiftPriorityQueue<Int>.init(hasHigherPriority: {
        return hasHigher(x: $0, compare: $1)
    }, isEqual: {
        $0 == $1
    })
    
    var result: String = ""
    nums.forEach {
        queue.enqueue($0)
    }
        
    while let value = queue.dequeue() {
        result.append("\(value)")
    }
        
    return result
}

func minNumber2(_ nums: [Int]) -> String {
    let queue = nums.sorted { return hasHigher(x: $0, compare: $1) }
    var result: String = ""
    queue.forEach {
        result.append("\($0)")
    }
    return result
}

func hasHigher(x: Int, compare y: Int) -> Bool {
    let aArr = [Character](String(x))
    let bArr = [Character](String(y))
    let resultA = Int(String(aArr + bArr)) ?? 0
    let resultB = Int(String(bArr + aArr)) ?? 0
    return resultA <= resultB
}

let arr = [34,3,30,5,9]
//let arr = [128, 12]
//let arr = [12, 121]

minNumber(arr)
minNumber2(arr)

//: [Next](@next)
