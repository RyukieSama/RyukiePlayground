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

let nums = [1,2,10,4,1,4,3,3]
//let nums = [4,1,4,6]
singleNumbers(nums)
singleNumbers1(nums)

//: [Next](@next)
