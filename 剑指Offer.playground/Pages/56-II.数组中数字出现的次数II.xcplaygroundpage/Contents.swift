//: [Previous](@previous)

import Foundation

/*:
 在一个数组 nums 中除一个数字只出现一次之外，其他数字都出现了三次。请找出那个只出现一次的数字。

 示例 1：

 输入：nums = [3,4,3,3]
 
 输出：4
 
 示例 2：

 输入：nums = [9,1,7,9,7,9,7]
 
 输出：1
 
 限制：

 1 <= nums.length <= 10000
 
 1 <= nums[i] < 2^31

 来源：力扣（LeetCode）
 
 链接：https://leetcode-cn.com/problems/shu-zu-zhong-shu-zi-chu-xian-de-ci-shu-ii-lcof
 
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */



/*:
 暴力
 */
func singleNumber(_ nums: [Int]) -> Int {
    var queue: [Int] = []
    
    for item in nums {
        if let lastIdx = queue.firstIndex(of: item) {
            queue.remove(at: lastIdx)
            queue.append(item)
        }
        else {
            queue.insert(item, at: 0)
        }
    }
    
    return queue[0]
}

/*:
 
 */
func singleNumber2(_ nums: [Int]) -> Int {
    
    return 0
}

let nums = [9,1,7,9,7,9,7]
singleNumber(nums)
//singleNumber2(nums)

//: [Next](@next)
