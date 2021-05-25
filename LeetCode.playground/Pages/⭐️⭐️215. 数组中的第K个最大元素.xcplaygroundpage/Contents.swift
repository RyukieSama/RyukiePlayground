//: [Previous](@previous)

import Foundation

/*:
 在未排序的数组中找到第 k 个最大的元素。请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。
 
 示例 1:
 
 输入: [3,2,1,5,6,4] 和 k = 2
 输出: 5
 示例 2:
 
 输入: [3,2,3,1,2,4,5,5,6] 和 k = 4
 输出: 4
 说明:
 
 你可以假设 k 总是有效的，且 1 ≤ k ≤ 数组的长度。
 
 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/kth-largest-element-in-an-array
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
    if nums.isEmpty || k == 0 {
        return 0
    }
    var nums1 = nums
    let length = nums1.count
    quickSearch(&nums1, 0, length - 1, length - k)

    return nums1[length - k]
}

func quickSearch(_ arr: inout [Int], _ low: Int, _ high: Int, _ k: Int) {
    let res = partition(&arr, low: low, high: high)
    if res == k {
        return
    }
    else if res > k {
        quickSearch(&arr, low, res-1, k)
    }
    else {
        quickSearch(&arr, res+1, high, k)
    }
}

func partition(_ arr: inout [Int], low: Int, high: Int) -> Int {
    var l = low
    var h = high
    while l < h {
        while (l < h && arr[h] >= arr[low]) {
            h = h - 1;
        }
        while (l < h && arr[l] <= arr[low]) {
            l = l + 1;
        }
        (arr[l], arr[h]) = (arr[h], arr[l])
    }
    (arr[low], arr[l]) = (arr[l], arr[low])
    return l // 返回tmp的正确位置
}

// MARK: - 使用的优先队列
func findKthLargestSwiftPriorityQueue(_ nums: [Int], _ k: Int) -> Int {
    var stack = SwiftPriorityQueue<Int>(hasHigherPriority: { $0 < $1 }, isEqual: { $0 == $1 })
    
    nums.forEach { item in
        if stack.peek() != item {
            stack.enqueue(item)
        }
        if stack.count > k {
            stack.dequeue()// 最高优先级的出列（最小的出去）
        }
    }
    
    return stack.peek() ?? 0// 获取最高优先级的
}


let nums = [3,2,3,1,2,4,5,5,6], k = 2

findKthLargest(nums, k)

findKthLargestSwiftPriorityQueue(nums, k)

//: [Next](@next)
