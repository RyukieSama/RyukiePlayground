//: [Previous](@previous)

import Foundation

/*:
 在数组中的两个数字，如果前面一个数字大于后面的数字，则这两个数字组成一个逆序对。输入一个数组，求出这个数组中的逆序对的总数。
  

 示例 1:

 输入: [7,5,6,4]
 
 输出: 5

 限制：

 0 <= 数组长度 <= 50000

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/shu-zu-zhong-de-ni-xu-dui-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
let n = [7,5,6,4]

/**
 2023-02-11
 
 看不懂
 */
//func reversePairs23211(_ nums: [Int]) -> Int {
//
//}



/// TimeOut
func reversePairs(_ nums: [Int]) -> Int {
    var dp: [Int : Int] = [:]
    var count = 0
    
    nums.forEach {
        dp[$0] = (dp[$0] ?? 0) + 1
        
        for item in dp {
            if item.key > $0 {
                count += item.value
            }
        }
        
    }
    
    return count
}


reversePairs(n)

//: [Next](@next)
