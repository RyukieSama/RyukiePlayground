//: [Previous](@previous)

import Foundation

/*:
 给定一个数组 A[0,1,…,n-1]，请构建一个数组 B[0,1,…,n-1]，其中 B[i] 的值是数组 A 中除了下标 i 以外的元素的积, 即 B[i]=A[0]×A[1]×…×A[i-1]×A[i+1]×…×A[n-1]。
 
 不能使用除法。

 示例:

 输入: [1,2,3,4,5]
 
 输出: [120,60,40,30,24]

 提示：

 所有元素乘积之和不会溢出 32 位整数
 
 a.length <= 100000

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/gou-jian-cheng-ji-shu-zu-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
let nums = [1,2,3,4,5]
/**
 2023-02-13
 */
func constructArr23213(_ a: [Int]) -> [Int] {
    guard a.count > 1 else {
        return []
    }
    var dpLeft: [Int] = [], dpRight: [Int] = []
    for idx in 0..<a.count {
        let left = a[idx], right = a[a.count - 1 - idx]

        if idx - 1 >= 0 {
            dpLeft.append(dpLeft[idx - 1] * left)
            dpRight.append(dpRight[idx - 1] * right)
        }
        else {
            dpLeft.append(left)
            dpRight.append(right)
        }
    }
    
    print(dpLeft)
    print(dpRight)
    
    var res: [Int] = []
    
    for idx in 0..<a.count {
        let left = idx - 1 >= 0 ? dpLeft[idx - 1] : 1
        let rightIdx = a.count - idx - 2
        let right = (rightIdx < a.count && rightIdx >= 0) ? dpRight[rightIdx] : 1
        res.append(left * right)
    }
    
    return res
}

constructArr23213(nums)


/*:
 动态规划
 */
func constructArr(_ a: [Int]) -> [Int] {
    guard a.isEmpty == false else {
        return []
    }
    var res: [Int] = []
    /// 某位之前的乘积
    var dpL: [Int : Int] = [0 : 1]
    /// 某位之后的乘积
    var dpR: [Int : Int] = [(a.count - 1) : 1]
    
    for idx in 1..<a.count {
        let lastIdx = idx - 1
        if let last = dpL[lastIdx] {
            dpL[idx] = last * a[lastIdx]
        }
        
        let backwordIdx = a.count - idx - 1
        if let last = dpR[backwordIdx + 1] {
            dpR[backwordIdx] = last * a[backwordIdx + 1]
        }
        
    }

    for idx in 0..<a.count {
        if let l = dpL[idx], let r = dpR[idx] {
            res.append(l * r)
        }
    }
    
    return res
}

constructArr(nums)

//: [Next](@next)
