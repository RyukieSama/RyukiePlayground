//: [上一题](@previous)

/*:
# 59-I-滑动窗口的最大值

## 题目

给定一个数组 nums 和滑动窗口的大小 k，请找出所有滑动窗口里的最大值。

## 用例

**输入：** nums = [1,3,-1,-3,5,3,6,7], 和 k = 3

**输出：** [3,3,5,5,6,7]

解释:

```
滑动窗口的位置                最大值
[1  3  -1] -3  5  3  6  7       3
1 [3  -1  -3] 5  3  6  7       3
1  3 [-1  -3  5] 3  6  7       5
1  3  -1 [-3  5  3] 6  7       5
1  3  -1  -3 [5  3  6] 7       6
1  3  -1  -3  5 [3  6  7]      7
```

## 提示

你可以假设 k 总是有效的，在输入数组不为空的情况下，1 ≤ k ≤ 输入数组的大小。

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/hua-dong-chuang-kou-de-zui-da-zhi-lcof)
*/
import Foundation

func maxWindow20261006(_ nums: [Int], k: Int) -> [Int] {
    guard nums.isEmpty == false, k <= nums.count, k >= 1 else {
        return []
    }
    var left = 0, right = k - 1
    // 当前窗口最大值的下标， key 是 right 的值
    var windowMaxValIdxOfRightIdx: [Int: Int] = [:]
    var result: [Int] = []
    
//    while left < right {
    while right < nums.count {
        let rightVal = nums[right]
        if let lastMaxIdx = windowMaxValIdxOfRightIdx[right - 1], lastMaxIdx >= left {
            // 还在范围内
            if rightVal > nums[lastMaxIdx] {
                windowMaxValIdxOfRightIdx[right] = right
                result.append(nums[right])
            }
            else {
                windowMaxValIdxOfRightIdx[right] = lastMaxIdx
                result.append(nums[lastMaxIdx])
            }
        }
        else { // 上一个最大不在范围内了，或者为空
            var maxVal: Int?
            
            for idx in left...right {
                let val = nums[idx]
                if let mv = maxVal {
                    if val > mv {
                        maxVal = val
                        windowMaxValIdxOfRightIdx[right] = idx
                    }
                }
                else {
                    maxVal = val
                    windowMaxValIdxOfRightIdx[right] = idx
                }
            }
            
            if let maxVal = maxVal {
                result.append(maxVal)
            }
        }
        
        left += 1
        right += 1
    }
    
    return result
}

/**
单调队列
 O(n)
 */
func maxWindow2(_ nums: [Int], k: Int) -> [Int] {
    guard !nums.isEmpty, k > 0, k <= nums.count else {
        return []
    }
    
    var result: [Int] = []
    var deque: [Int] = []
    var head = 0
    
    for i in nums.indices {
        while head < deque.count,
              deque[head] <= i - k {
            head += 1
        }
        
        while deque.count > head,
              nums[deque.last!] <= nums[i] {
            deque.removeLast()
        }
        
        deque.append(i)
        
        if i >= k - 1 {
            result.append(nums[deque[head]])
        }
    }
    
    return result
}

/**
非动态规划
 
 最坏时间复杂度：O(n × k)
 空间复杂度：O(n)
 */
func maxWindow(_ nums: [Int], k: Int) -> [Int] {
    guard
        nums.isEmpty == false,
        k <= nums.count,
        k >= 1
    else {
        return []
    }
    var res: [Int] = []
    var left = 0, right = k - 1
    // right 为某值时 最大值的下标
    var maxValRightEdgeIndex: [Int: Int] = [:]
    
    while right < nums.count {
        let rightV = nums[right]
        
        if let lastMaxIdx = maxValRightEdgeIndex[right - 1], lastMaxIdx >= left {
            // 上个最大值的idx还在当前区间内
            if rightV > nums[lastMaxIdx] {
                res.append(rightV)
                maxValRightEdgeIndex[right] = right
            }
            else {
                res.append(nums[lastMaxIdx])
                maxValRightEdgeIndex[right] = lastMaxIdx
            }
        }
        else {
            var currentMaxRight = right
            var currentV = nums[right]
            
            for idx in left...right {
                if nums[idx] > currentV {
                    currentV = nums[idx]
                    currentMaxRight = idx
                }
            }
            
            maxValRightEdgeIndex[right] = currentMaxRight
            res.append(currentV)
        }
        
        right += 1
        left += 1
    }
    
    return res
}

/*:
## 单调队列解析

滑动窗口最大值可以使用单调递减队列优化。队列保存的是元素下标，并保证对应的元素值从队首到队尾依次递减，因此队首始终是当前窗口的最大值。

### 为什么保存下标

窗口不断向右移动，需要判断某个元素是否已经离开窗口。下标小于当前窗口左边界的元素已经过期，必须从队首移除。只保存数值无法判断元素是否过期。

### 为什么从队尾移除较小值

如果当前新元素比队尾元素大，那么队尾元素以后不可能成为最大值：当前元素比它大，而且当前元素还会比它晚离开窗口。因此可以从队尾移除所有不可能成为最大值的较小元素，再加入当前下标。

队列始终保持：

```text
nums[队首] >= nums[队首之后] >= ... >= nums[队尾]
```

### 每个位置的处理步骤

1. 移除已经滑出窗口的队首下标。
2. 从队尾移除所有不大于当前值的下标。
3. 加入当前下标。
4. 当窗口大小达到 `k` 后，取队首对应的值作为当前窗口最大值。

例如窗口 `[1,3,-1]` 的单调队列只需保存 `[3,-1]`，队首 `3` 就是最大值。加入更大的 `5` 时，`-1` 和 `3` 都会从队尾移除，最后队列变成 `[5]`。

### 与当前缓存方案的区别

当前缓存方案在最大值离开窗口后需要重新扫描整个窗口，最坏复杂度为 `O(n × k)`。单调队列会提前移除不可能成为最大值的元素，因此不需要重新扫描。

### 复杂度

- 时间复杂度：`O(n)`，每个下标最多入队和出队一次。
- 额外空间复杂度：`O(k)`，用于保存当前窗口候选下标。
*/
//: [下一题](@next)
