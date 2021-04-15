//: [Previous](@previous)

import Foundation

/*:
 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。输入一个递增排序的数组的一个旋转，输出旋转数组的最小元素。例如，数组 [3,4,5,1,2] 为 [1,2,3,4,5] 的一个旋转，该数组的最小值为1。
 
 示例 1：
 
 输入：[3,4,5,1,2]
 输出：1
 示例 2：
 
 输入：[2,2,2,0,1]
 输出：0
 注意：本题与主站 154 题相同：https://leetcode-cn.com/problems/find-minimum-in-rotated-sorted-array-ii/
 
 
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/xuan-zhuan-shu-zu-de-zui-xiao-shu-zi-lcof
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

let num = [1, 1]

func minArray(_ numbers: [Int]) -> Int {
    // 正序 发现后一个比前一个小，就是后一个
    // 逆序 发现下一个比上一个大，就是上一个
    
    if numbers.count == 1 {
        return numbers[0]
    }
    
    if numbers.count == 2 {
        return numbers[0] >= numbers[1] ? numbers[1] : numbers[0]
    }
    
    var offset = 0
    let halfOffset = Int(floor(Double(numbers.count) / 2.0))
    
    if numbers[0] < numbers[numbers.count - 1] {
        return numbers[0]
    }
    
    while offset <= halfOffset {
        
        // 正序的
        if numbers[offset] > numbers[offset + 1] {
            return numbers[offset + 1]
        }
        
        // 逆序的
        if numbers[numbers.count - 1 - offset] < numbers[numbers.count - 2 - offset] {
            return numbers[numbers.count - 1 - offset]
        }
        
        offset += 1
    }
    
    return numbers[0]// 全部相同随便取个
}

minArray(num)

//: [Next](@next)
