//: [Previous](@previous)

import Foundation

/*:
 给你两个有序整数数组 nums1 和 nums2，请你将 nums2 合并到 nums1 中，使 nums1 成为一个有序数组。
 
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n 。你可以假设 nums1 的空间大小等于 m + n，这样它就有足够的空间保存来自 nums2 的元素。
 
 
 示例 1：
 
 输入：nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 输出：[1,2,2,3,5,6]
 示例 2：
 
 输入：nums1 = [1], m = 1, nums2 = [], n = 0
 输出：[1]
  
 
 提示：
 
 nums1.length == m + n
 nums2.length == n
 0 <= m, n <= 200
 1 <= m + n <= 200
 -109 <= nums1[i], nums2[i] <= 109
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/merge-sorted-array
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

var nums1 = [1,2,3,0,0,0]
let m = 3
let nums2 = [2,5,6]
let n = 3

// 先插入，再冒泡  太蠢了

// 逆序双指针
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
    var mRight = m - 1
    var nRight = n - 1
    
    while nRight >= 0 {
        if mRight >= 0 && nums1[mRight] > nums2[nRight] {
            nums1[mRight + nRight + 1] = nums1[mRight]
            mRight -= 1
        } else {
            nums1[mRight + nRight + 1] = nums2[nRight]
            nRight -= 1
        }
    }
}

merge(&nums1, m, nums2, n)

//: [Next](@next)
