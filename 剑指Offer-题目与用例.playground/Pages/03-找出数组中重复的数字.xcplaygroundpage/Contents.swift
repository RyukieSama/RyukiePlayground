//: [上一题](@previous)

/*:
# 03-找出数组中重复的数字

## 题目

找出数组中重复的数字。

在一个长度为 n 的数组 nums 里的所有数字都在 0～n-1 的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。

## 用例 1

**输入：** 
[2, 3, 1, 0, 2, 5, 3]
**输出：** 2 或 3

## 约束

2 <= n <= 100000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/shu-zu-zhong-zhong-fu-de-shu-zi-lcof)
*/
let datas = [2, 3, 1, 0, 2, 5, 3]

func find_20260914(_ nums: [Int]) -> Int {
    var nums = nums
    
//    // 这里遍历的是快照，所以错啦
//    for (idx, val) in nums.enumerated() {
//        if idx == val {
//            continue
//        }
//        else if val == nums[val] {
//            return val
//        }
//        else {
//            nums.swapAt(val, idx)
//        }
//    }
    
    var p = 0
    
    while p < nums.count {
        let val = nums[p]
        if p == val {
            p += 1
        }
        else if val == nums[val] {
            return val
        }
        else {
            nums.swapAt(p, val)
//            p += 1 // 这里不该移动，应该停在原地，继续检查换来的值
        }
    }
    
    return 0
}

find_20260914(datas)

/*:
## 错误解析

### 1. 原来的 `enumerated()` 会让值与数组状态不同步

`nums.enumerated()` 基于开始遍历时的数组生成序列。循环内执行 `swapAt` 后，
局部数组已经发生变化，但后续取得的 `val` 仍可能来自原来的遍历序列。

因此，下面三个值可能不再描述同一个状态：

- `idx`：当前遍历下标
- `val`：遍历序列提供的旧值
- `nums[idx]`：交换后位于该下标的新值

### 2. 当前的 `while` 版本在交换后仍然过早移动了指针

一次交换只能确保值为 `val` 的元素被放到下标 `val`，但交换到 `p` 位置的
新元素不一定已经处于正确位置。因此，执行 `swapAt` 后不能立即执行 `p += 1`，
而是应该留在当前下标继续检查。

例如：

```
nums = [0, 2, 0]

p = 0：nums[0] == 0，移动到下一位
p = 1：交换 nums[1] 和 nums[2]
       数组变为 [0, 0, 2]
```

交换后再次检查 `p = 1`，才能发现 `nums[1]` 与 `nums[0]` 都是 `0`。
如果此时直接移动到 `p = 2`，这个重复数字就会被漏掉。

## 注意事项

- 只有当 `nums[p] == p` 时，才说明当前位置已经整理完成，此时才能执行 `p += 1`。
- 执行交换后应保留当前下标，并在下一轮重新读取 `nums[p]`。
- 访问 `nums[val]` 依赖题目条件：所有数字必须位于 `0...n-1`，否则可能数组越界。
- `0` 是合法数字，也可能就是重复数字，不能用 `return 0` 表示“没有找到”。
  若需要异常兜底值，可以使用 `-1`。
- `var nums = nums` 不会修改调用方传入的数组；但 Swift 数组采用写时复制，
  首次修改局部副本时可能产生一次完整复制。
*/

//: [下一题](@next)
