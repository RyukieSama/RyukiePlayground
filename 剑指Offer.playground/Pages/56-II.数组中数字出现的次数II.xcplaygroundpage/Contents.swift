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
let nums = [9,1,7,9,7,9,7]

/**
 2023-02-12
 */
func singleNumber23212(_ nums: [Int]) -> Int {
    /**
     例如： 001，001，001，0010
     各位和为 0013
     由于每个数二进制都由0 和 1 组成，所以相同的三个数的各个位和，一定为 3 的倍数
     我们将各个位的和，分别对3取余，各位剩下的，组成的就是那独立的一个数的二进制表示
     */
    var digArray: [Int] = Array(repeating: 0, count: 32)
    
    for n in nums {
        var temp = n
        for idx in 0..<32 {
            if temp & 1 == 1 {
                digArray[31 - idx] += 1
            }
            temp >>= 1
        }
    }
//    print(digArray)
    digArray = digArray.map { return $0 % 3 }
//    print(digArray)
    var res = 0
    for (idx, dig) in digArray.enumerated() {
        if dig == 1 {
            res += Int(pow(2, Double(31 - idx)))
        }
    }
    return res
}

singleNumber23212(nums)



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
singleNumber(nums)
//singleNumber2(nums)

//: [Next](@next)
