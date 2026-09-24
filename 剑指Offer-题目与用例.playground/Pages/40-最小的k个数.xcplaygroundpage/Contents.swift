//: [上一题](@previous)

/*:
# 40-最小的k个数

## 题目

输入整数数组 arr ，找出其中最小的 k 个数。例如，输入4、5、1、6、2、7、3、8这8个数字，则最小的4个数字是1、2、3、4。

## 用例 1

```
输入：arr = [3,2,1], k = 2
输出：[1,2] 或者 [2,1]
```

## 用例 2

```
输入：arr = [0,1,2,1], k = 1
输出：[0]
```

## 约束

0 <= k <= arr.length <= 10000
0 <= arr[i] <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/zui-xiao-de-kge-shu-lcof)
*/

func min(nums: inout [Int], k: Int) -> [Int] {
    guard k > 0, k <= nums.count else {
        return []
    }
    
    for j in 0..<k {
        for i in j+1..<nums.count {
            let vj = nums[j], vi = nums[i]
            if vj > vi {
                nums.swapAt(j, i)
            }
        }
    }
    
    return Array(nums[0..<k])
}

/*:
## 题目解析

这道题要求返回数组中最小的 `k` 个数，返回顺序不作要求。

当前解法使用的是**部分选择排序**：只进行前 `k` 轮，每一轮把当前未处理区间中的最小值放到正确位置。

### 处理过程

```swift
for j in 0..<k {
    for i in j+1..<nums.count {
        if nums[j] > nums[i] {
            nums.swapAt(j, i)
        }
    }
}
```

- 第 `0` 轮：在整个数组中找最小值，放到 `nums[0]`。
- 第 `1` 轮：在剩余区间中找最小值，放到 `nums[1]`。
- 继续执行，直到前 `k` 个位置都确定。

例如：

```text
nums = [3, 2, 1], k = 2
```

第一轮确定 `1`：

```text
[1, 3, 2]
```

第二轮确定 `2`：

```text
[1, 2, 3]
```

最后返回前两个元素 `[1, 2]`。

### 边界处理

```swift
guard k > 0, k <= nums.count else {
    return []
}
```

- `k == 0`：没有需要返回的数字，返回空数组。
- `k > nums.count`：请求数量超过数组长度，返回空数组。
- `nums` 为空时也会返回空数组。

### 注意 `inout`

函数参数使用 `inout`，所以排序过程会直接修改调用方传入的原数组。如果不希望修改原数组，可以先复制：

```swift
var values = nums
```

### 复杂度

- 时间复杂度：`O(n × k)`。
- 额外空间复杂度：`O(1)`。

当前实现已经正确。若使用大小为 `k` 的大根堆，可以将时间复杂度优化为 `O(n log k)`，但实现复杂度也会更高。
*/

//: [下一题](@next)
