//: [Previous](@previous)

import Foundation

/*:
 0,1,···,n-1这n个数字排成一个圆圈，从数字0开始，每次从这个圆圈里删除第m个数字（删除后从下一个数字开始计数）。求出这个圆圈里剩下的最后一个数字。

 例如，0、1、2、3、4这5个数字组成一个圆圈，从数字0开始每次删除第3个数字，则删除的前4个数字依次是2、0、4、1，因此最后剩下的数字是3。

 示例 1：
 
 输入: n = 5, m = 3
 
 输出: 3
 
 示例 2：

 输入: n = 10, m = 17
 
 输出: 2
  
 限制：

 1 <= n <= 10^5
 1 <= m <= 10^6

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

// 超时
func lastRemaining(_ n: Int, _ m: Int) -> Int {
    var right = m - 1
    var nums: [Int] = Array(0..<n)
    
    while nums.count > 1 {
        right = (right < nums.count) ? right : (right % nums.count)
        
        nums.remove(at: right)
        
        right += (m - 1)
    }
    
    return nums[0]
}

/*:
 数学解法：https://leetcode-cn.com/problems/yuan-quan-zhong-zui-hou-sheng-xia-de-shu-zi-lcof/solution/javajie-jue-yue-se-fu-huan-wen-ti-gao-su-ni-wei-sh/
 
 能力有限。理解不能
 
 */

lastRemaining(10, 17)

//: [Next](@next)
