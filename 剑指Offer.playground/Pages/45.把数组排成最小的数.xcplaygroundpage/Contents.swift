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

var arr = [34,3,30,5,9]
arr = [128, 12]
arr = [12, 121]

/**
 2023-02-10
 */
func minNumber23210(_ nums: [Int]) -> String {
    /**
     排序条件：
     1234 对比 234
     1, 2, 3, 4 < - > 2, 3, 4
     
     从各自最高位开始对比，一旦发现更小的，就往前放
     */
    var nums = nums.sorted{ isSmaller23210(x: $0, than: $1) }
    var res = ""
    nums.forEach {
        res.append("\($0)")
    }
    return res
}

func isSmaller23210(x: Int, than y: Int) -> Bool {
//    var xArr: [Int] = [], yArr: [Int] = []
//    Array("\(x)").forEach {
//        if let val = Int(String($0)) {
//            xArr.append(val)
//        }
//    }
//    Array("\(y)").forEach {
//        if let val = Int(String($0)) {
//            yArr.append(val)
//        }
//    }
//    var idx = 0
//    while idx < xArr.count, idx < yArr.count {
//        if xArr[idx] == yArr[idx] {
//            idx += 1
//        }
//        else {
//            return xArr[idx] < yArr[idx]
//        }
//    }
//    return false
    
    let aArr = [Character](String(x))
    let bArr = [Character](String(y))
    let resultA = Int(String(aArr + bArr)) ?? 0
    let resultB = Int(String(bArr + aArr)) ?? 0
    return resultA <= resultB
}

isSmaller23210(x: 30, than: 3)

minNumber23210(arr)


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

minNumber(arr)
minNumber2(arr)

//: [Next](@next)
