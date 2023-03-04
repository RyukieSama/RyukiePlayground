//: [Previous](@previous)

import Foundation

/*:
一个整型数组 nums 里除两个数字之外，其他数字都出现了两次。请写程序找出这两个只出现一次的数字。要求时间复杂度是O(n)，空间复杂度是O(1)。

 
示例 1：

输入：nums = [4,1,4,6]

输出：[1,6] 或 [6,1]

 
示例 2：

输入：nums = [1,2,10,4,1,4,3,3]

输出：[2,10] 或 [10,2]
 
限制：

2 <= nums.length <= 10000

来源：力扣（LeetCode）

链接：https://leetcode-cn.com/problems/shu-zu-zhong-shu-zi-chu-xian-de-ci-shu-lcof

著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

*/

var nums = [1,2,10,4,1,4,3,3]
//nums = [4,1,4,6]

/**
 2023-03-04
 */
func singleNumbers230304(_ nums: [Int]) -> [Int] {
    guard nums.isEmpty == false else {
        return []
    }
    var temp = nums[0]
    for idx in 1..<nums.count {
        temp ^= nums[idx]
    }
    
    var one = 1
    
    while temp & one == 0 {
        one <<= 1
    }
    
    var x = 0, y = 0// x: 这位为1 的 y：这位为0的
    
    for n in nums {
        if n & one != 0 {
            x ^= n
        }
        else {
            y ^= n
        }
    }
    
    return [x, y]
}
singleNumbers230304(nums)


/**
 2023-02-26
 */
func singleNumbers23226(_ nums: [Int]) -> [Int] {
    guard nums.count > 2 else {
        return nums
    }
    var or: Int = 0, p = 1, x = 0, y = 0
    
    for n in nums {
        // 相同数组异或就是0
        or ^= n
    }
    
    /**
     有两个数不同，必定 or 不为 0，有一位为1
     可以将原数组分为两部分：
     - 所有元素异或结果这一位为 1 的，子数组，遍历异或结果为 x
     - 所有元素异或结果这一位为 0 的，子数组，遍历异或结果为 y
     
     结果就是 [x, y]
     
     那么找出这个为 1 的位就行了
     */
    
    while or & p == 0 {
        p <<= 1
    }
    
    for n in nums {
        if n & p != 0 {
            x ^= n
        }
        else {
            y ^= n
        }
    }
    
    return [x, y]
}
singleNumbers23226(nums)




/**
 2023-02-12
 */
func singleNumbers23212(_ nums: [Int]) -> [Int] {
    var res = 0
    /**
     异或过滤出，会过滤掉相同的数字
     */
    nums.forEach {
        res ^= $0
    }
    
    /**
     必定两个不同数字，异或结果二进制位中一定有一位是 1，找到这一位
     */
    var p = 1
    while res & p == 0 {
        p <<= 1
    }
    
    /**
     由此，将数组分为两部分
     该位为 1 的，设 x 为所有元素异或的结果
     该位为 0 的，设 y 为所有元素异或的结果
     */
    var x = 0, y = 0
    
    nums.forEach {
        if $0 & p > 0 {
            // $0 这一位是1
            x ^= $0
        }
        else {
            // $0 这一位是0
            y ^= $0
        }
    }
    
    return [x, y]
}




/// 控件复杂度不符合要求
func singleNumbers(_ nums: [Int]) -> [Int] {
    var res: [Int] = []
    
    nums.forEach {
        if let last = res.firstIndex(of: $0) {
            res.remove(at: last)
        }
        else {
            res.insert($0, at: 0)
        }
    }
    
    return res
}

/*:
 HashMap 解法很容易想到，但是不符合空间复杂度的要求。
 
 0001
 0010
 1010
 0100
 0001
 0100
 0011
 0011
 
 设结果为 x y
 
 全员异或结果 n = x ^ y = 1000
 
 如果只有一个不同的话全员异或就能得出结果，本题我们如果能够将数组拆分为两个是不是就能得出结果了？
 
 那么怎么分成两个数组呢？要拆分需要一个基准，即一个用来区分两个数组元素不同的点
 
 我们回到 n ，我们可以知道必有两个不同的，所以结果 n 必定至少有一位为 1，那么我们可以分为两组：
 
 * 这一位为 1 的元素
 * 这一位为 0 的元素
 
 为了找到这一位1，我们定义一个临时变量 t = 1，逐步左移 & n 找到为1的情况。
 
 接下来便利元素，通过 & t 是否大于 1 来区分元素，分别累积异或 x 或者 y
 
 最终的 x，y 就是我们要找的两个元素了
 
 时间复杂度 O(N) 或者说是 2N，控件复杂度 O(1)
 
 */

/// 位运算
func singleNumbers1(_ nums: [Int]) -> [Int] {
    var x = 0, y = 0, n = 0, t = 1
    nums.forEach { n ^= $0 }
    while (t & n) == 0 { t <<= 1 }
    nums.forEach {
        (($0 & t) >= 1) ? (x ^= $0) : (y ^= $0)
    }
    return [x, y]
}

singleNumbers(nums)
singleNumbers1(nums)

//: [Next](@next)
