//: [Previous](@previous)

import Foundation

/*:
 编写一个函数，输入是一个无符号整数（以二进制串的形式），返回其二进制表达式中数字位数为 '1' 的个数（也被称为 汉明重量).）。

 提示：

 请注意，在某些语言（如 Java）中，没有无符号整数类型。在这种情况下，输入和输出都将被指定为有符号整数类型，并且不应影响您的实现，因为无论整数是有符号的还是无符号的，其内部的二进制表示形式都是相同的。
 在 Java 中，编译器使用 二进制补码 记法来表示有符号整数。因此，在上面的 示例 3 中，输入表示有符号整数 -3。

 示例 1：

 输入：n = 11 (控制台输入 00000000000000000000000000001011)
 输出：3
 解释：输入的二进制串 00000000000000000000000000001011 中，共有三位为 '1'。
 示例 2：

 输入：n = 128 (控制台输入 00000000000000000000000010000000)
 输出：1
 解释：输入的二进制串 00000000000000000000000010000000 中，共有一位为 '1'。
 示例 3：

 输入：n = 4294967293 (控制台输入 11111111111111111111111111111101，部分语言中 n = -3）
 输出：31
 解释：输入的二进制串 11111111111111111111111111111101 中，共有 31 位为 '1'。

 提示：
 输入必须是长度为 32 的 二进制串 。
  
 注意：本题与主站 191 题相同：https://leetcode-cn.com/problems/number-of-1-bits/

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/er-jin-zhi-zhong-1de-ge-shu-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 2023-02-27
 */
func hammingWeight23227(_ n: Int) -> Int {
    var count = 0, n = n
    
    while n > 0 {
        if n & 1 == 1 {
            count += 1
        }
        n >>= 1
    }
    
    return count
}
hammingWeight23227(0b11_1111001111_1111100111_1111111111)

/**
 一位一位右移，每次判断最后一位
 */
func hammingWeight(_ n: Int) -> Int {
    var count = 0
    var temp = n
    
    while temp > 0 {
        count += (temp & 1 == 1) ? 1 : 0
        temp >>= 1
    }

    return count
}

hammingWeight(0b11_1111001111_1111100111_1111111111)
//hammingWeight(0x80000000)

/*:
 如果支持负数呢？
 
 0x80000000 是一个负数，右移就不是 0x40000000了，是0xC0000000
 右移会以符号位填补空白，负数就是1，证书为0
 如果单存的右移的话就会死循环
 这里换个思路，移动1
 
 知识补充：
 负数在计算机中二进制用补码标识
 负数的补码：除符号位其余各位取反，然后+1
 */

func hammingWeight2(_ n: Int) -> Int {
    var count: Int = 0
    var flag: Int = 1
    
    while (flag != 0) {
        count += (n & flag == flag) ? 1 : 0
        if flag < 0 {// 最高位为1
            return count
        }
        flag <<= 1
    }

    return count
}

hammingWeight2(-7)
//hammingWeight2(7)

/**
 2023-02-04
 同时兼容有符号无符号
 */

func hammingWeight3(_ n: Int) -> Int {
    var count = 0
    var flag = 1
    
    while flag != 0 {
        //        print(flag)
        if (n & flag == flag) {
            count+=1
        }
        flag <<= 1
    }
    
    return count
}

hammingWeight3(-7)

//: [Next](@next)
