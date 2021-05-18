//: [Previous](@previous)

import Foundation

/*:
 给你一个整数数组 perm ，它是前 n 个正整数的排列，且 n 是个 奇数 。
 
 它被加密成另一个长度为 n - 1 的整数数组 encoded ，满足 encoded[i] = perm[i] XOR perm[i + 1] 。比方说，如果 perm = [1,3,2] ，那么 encoded = [2,1] 。
 
 给你 encoded 数组，请你返回原始数组 perm 。题目保证答案存在且唯一。
 
 示例 1：
 
 输入：encoded = [3,1]
 输出：[1,2,3]
 解释：如果 perm = [1,2,3] ，那么 encoded = [1 XOR 2,2 XOR 3] = [3,1]
 示例 2：
 
 输入：encoded = [6,5,4,6]
 输出：[2,4,1,5,3]
  
 
 提示：
 
 3 <= n < 105
 n 是奇数。
 encoded.length == n - 1
 
 链接：https://leetcode-cn.com/problems/decode-xored-permutation
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/*:
 解题思路

 由于 encoded[i] = perm[i] ^ perm[i+1]
 所以，令：
 y = perm[1] ^ perm[2] ^ perm[3] ^ ... ^ perm[n-1]
 y = encoded[1] ^ encoded[3] ^ ... ^ encoded[n-2]

 同时我们可以算出 1...n 的异或结果，令：
 x = perm[0] ^ perm[1] ^ perm[2] ^ ... ^ perm[n-1]
 得出：
 perm[0] = x ^ y

 然后根据 perm[0] 对 encoded 依次异或即可

 作者：talaxy
 链接：https://leetcode-cn.com/problems/decode-xored-permutation/solution/swift-1734-jie-ma-yi-huo-hou-de-pai-lie-g3uyu/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

func decode(_ encoded: [Int]) -> [Int] {
    let len = encoded.count
    
    // 原数组是前n个正整数的排列，x为依次异或的结果
    var x = 0
    for i in 1...(len+1) {
        x = x ^ i
    }
    
    // 结果是两个两个异或得到的，y通过跳位的异或的到，比x少一个起始位的，所以x、y异或会得到起始位的值。然后按位异或即可得到原数组
    var y = 0
    for i in stride(from: 1, to: len, by: 2) {
        y = y ^ encoded[i]
    }
    
    var perm: [Int] = [], current = x ^ y
    perm.append(current)
    for n in encoded {
        current = current ^ n
        perm.append(current)
    }
    return perm
}


let encoded = [6,5,4,6]

decode(encoded)
//: [Next](@next)
