//: [上一题](@previous)

/*:
# 21-调整数组顺序使奇数位于偶数前面

## 题目

输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位于数组的后半部分。

## 用例

**输入：** nums = [1,2,3,4]
**输出：** [1,3,2,4]
注：[3,1,2,4] 也是正确的答案之一。

## 提示

0 <= nums.length <= 50000
1 <= nums[i] <= 10000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/diao-zheng-shu-zu-shun-xu-shi-qi-shu-wei-yu-ou-shu-qian-mian-lcof)
*/

func reOrder(_ nums: [Int]) -> [Int] {
    guard nums.count > 1 else {
        return nums
    }
    var nums = nums, left = 0, right = nums.count - 1
    while left < right {
        let lv = nums[left], rv = nums[right]
        if lv & 1 == 1 {
            // 奇数
            left += 1
        }
        else {
            // 偶数
            if rv & 1 == 1 {
                // 右边是奇数，左右交换，然后左右各前进一步
                nums.swapAt(left, right)
                left += 1
                right -= 1
            }
            else {
                // 右边也是偶数，继续向左找
                right -= 1
            }
        }
    }
    return nums
}


/*:
## 双指针解析与空间优化

### 核心思路

使用两个指针从数组两端向中间移动：

- `left` 从左向右寻找偶数。
- `right` 从右向左寻找奇数。

当左边是偶数、右边是奇数时，交换两个元素，使奇数移动到前面、偶数移动到后面。

### 三种情况

1. 左边元素是奇数：当前位置已经符合要求，`left += 1`。
2. 左边是偶数、右边是奇数：交换两个元素，然后两个指针向中间移动。
3. 左边和右边都是偶数：`right -= 1`，继续从右侧寻找奇数。

循环过程中可以保持：

```text
left 左侧已经全部是奇数
right 右侧已经全部是偶数
```

题目不要求保持奇数或偶数的原有相对顺序，因此交换是合法的。

### 原实现的空间

当前函数返回一个数组，并在函数内部声明：

```swift
var nums = nums
```

双指针本身只使用常量个变量，但返回新数组通常需要 `O(n)` 结果空间。

### `O(1)` 空间优化

如果允许直接修改传入数组，可以使用 `inout`：

```swift
func reOrder(_ nums: inout [Int]) {
    guard nums.count > 1 else { return }
    
    var left = 0
    var right = nums.count - 1
    
    while left < right {
        if (nums[left] & 1) == 1 {
            left += 1
        }
        else if (nums[right] & 1) == 1 {
            nums.swapAt(left, right)
            left += 1
            right -= 1
        }
        else {
            right -= 1
        }
    }
}
```

调用方式：

```swift
var nums = [1, 2, 3, 4]
reOrder(&nums)
```

### 复杂度

- 时间复杂度：`O(n)`。
- 当前返回新数组的版本：结果空间为 `O(n)`。
- `inout` 原地修改版本：额外空间为 `O(1)`。
*/

//: [下一题](@next)
