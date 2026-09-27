//: [上一题](@previous)

/*:
# 57-II-和为s的连续正数序列

## 题目

输入一个正整数 target ，输出所有和为 target 的连续正整数序列（至少含有两个数）。

序列内的数字由小到大排列，不同序列按照首个数字从小到大排列。

## 用例 1

**输入：** target = 9

**输出：** [[2,3,4],[4,5]]

## 用例 2

**输入：** target = 15

**输出：** [[1,2,3,4,5],[4,5,6],[7,8]]

## 约束

1 <= target <= 10^5

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/he-wei-sde-lian-xu-zheng-shu-xu-lie-lcof)
*/

//func find(_ target: Int) -> [[Int]] {
//    /**
//     x + x+1
//     x + x+1 + x+2
//     x + x+1 + x+2 + x+3
//     ...
//     
//     N个连续数
//     
//     2个数 赠量 1
//     3个数 增量 1+2
//     4个数 增量 1+2+3
//     5个数 增量 1+2+3+4
//     
//     first x N + 增量和 = target
//     */
//    var addSum: [Int: Int] = [:]
//    addSum[2] = 1
//    var res: [[Int]] = []
//    var digN = 2
//    
//    /// dig 个数组成的序列
//    func nums(of dig: Int) -> [Int]? {
//        var sub: [Int] = []
//        var baseSum: Int?
//        
//        if let add = addSum[dig] {
//            baseSum = target - add
//        }
//        else if dig - 1 >= 0, let last = addSum[dig - 1] {
//            let v = last + (dig - 1)
//            addSum[dig] = v
//            baseSum = target - v
//        }
//        
//        guard
//            let baseSum = baseSum,
//            baseSum % dig == 0 // 必须能被整除
//        else {
//            return nil
//        }
//        
//        let base = baseSum / dig
//        for idx in 0..<dig {
//            sub.append(base + idx)
//        }
//        return sub
//    }
//    
//    // 这里遇到某个长度无解时，nums(of:) 返回 nil，循环就直接结束了。
//    while let subRes = nums(of: digN), subRes.isEmpty == false {
//        res.append(subRes)
//        digN += 1
//    }
//    
//    return res
//}

// 滑动窗口
func find(_ target: Int) -> [[Int]] {
    var result: [[Int]] = []
    
    var left = 1
    var right = 2
    var sum = 3
    
    while left < right {
        if sum == target {
            result.append(Array(left...right))
            
            // 继续扩大窗口，寻找后续序列
            right += 1
            sum += right
        }
        else if sum < target {
            right += 1
            sum += right
        }
        else {
            sum -= left
            left += 1
        }
    }
    
    return result
}

/*:
## 滑动窗口解析

可以把当前连续正整数序列看成一个窗口 `[left...right]`，并维护窗口中所有数字的和 `sum`。

窗口初始为 `[1,2]`，因此 `sum = 3`。每次根据 `sum` 与 `target` 的关系调整窗口：

- `sum < target`：窗口中的数字之和太小，向右扩展，执行 `right += 1` 并把新数字加入 `sum`；
- `sum > target`：窗口中的数字之和太大，移除最左侧数字，执行 `sum -= left` 和 `left += 1`；
- `sum == target`：记录当前窗口，然后继续移动 `right`，寻找其他合法序列。

例如 `target = 9`：

```text
[1,2]       sum = 3
[1,2,3]     sum = 6
[1,2,3,4]   sum = 10，移除 1
[2,3,4]     sum = 9，记录结果
```

继续移动窗口后，可以得到 `[4,5]`，最终结果是 `[[2,3,4], [4,5]]`。

窗口中的数字天然是连续递增的，因此不需要额外检查连续性。`left` 和 `right` 都只向右移动，每个数字最多进入和离开窗口一次。

### 复杂度

- 时间复杂度：`O(target)`；
- 额外空间复杂度：`O(1)`，不计算保存结果的数组。
*/
//: [下一题](@next)
