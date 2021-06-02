//: [Previous](@previous)

import Foundation

/*:
 给定一个整数，写一个函数来判断它是否是 4 的幂次方。如果是，返回 true ；否则，返回 false 。
 
 整数 n 是 4 的幂次方需满足：存在整数 x 使得 n == 4x
 
  
 
 示例 1：
 
 输入：n = 16
 输出：true
 示例 2：
 
 输入：n = 5
 输出：false
 示例 3：
 
 输入：n = 1
 输出：true
  
 
 提示：
 
 -2^31 <= n <= 2^31 - 1
  
 
 进阶：
 
 你能不使用循环或者递归来完成本题吗？
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/power-of-four
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

// MARK: - 遍历
func isPowerOfFour1(_ n: Int) -> Bool {
    if n <= 0 {
        return false
    }
    var temp = n
    while temp % 4 == 0 {
        temp /= 4
    }
    
    return temp == 1
}

// MARK: - 二进制
func isPowerOfFour2(_ n: Int) -> Bool {
    /*:
     1     = 0000 0000 0000 0001
     4     = 0000 0000 0000 0100
     16   = 0000 0000 0001 0000
     64   = 0000 0000 0100 0000
     256 = 0000 0001 0000 0000
     ...
     0000 0000 0000 0000 0000 0000 0000 0000
     都是向前进两位，奇数位为1，其他都是0
     我们搞个偶数位全部为1的，按位与一下，结果为0就对了
     1010 1010 1010 1010 1010 1010 1010 1010
     0b10101010101010101010101010101010
     我们用16进制来标识
     八进制为0o
     */
    let base = 0b10101010101010101010101010101010
    // 但是末位为1的话与后也是0，需要单独判断下
    return (n & base == 0) && (n > 0) && (n & (n - 1) == 0)
}

// MARK: - 取余法-没看懂

/*:
 在方法二基础上改良下， 因为如果是4次幂则必有 n % 3 == 1;
 先判断 n>0 且 n是2次方， 第三个判断条件用 n % 3 == 1判断


 class Solution {
     func isPowerOfFour(_ n: Int) -> Bool {
         return n > 0 && (n & (n - 1)) == 0 && n % 3 == 1;
     }
 }

 */

func isPowerOfFour3(_ n: Int) -> Bool {
    if n <= 0 {
        return false
    }
    return false
}

let n = 17
isPowerOfFour1(n)
isPowerOfFour2(n)
isPowerOfFour3(n)

//: [Next](@next)
