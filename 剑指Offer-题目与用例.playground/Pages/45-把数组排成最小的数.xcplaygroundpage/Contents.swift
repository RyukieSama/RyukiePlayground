//: [上一题](@previous)

/*:
# 45-把数组排成最小的数

## 题目

输入一个非负整数数组，把数组里所有数字拼接起来排成一个数，打印能拼接出的所有数字中最小的一个。

## 用例 1

**输入：** [10,2]
**输出：** "102"
## 用例 2

**输入：** [3,30,34,5,9]
**输出：** "3033459"

## 提示

0 < nums.length <= 100
## 说明

输出结果可能非常大，所以你需要返回一个字符串而不是整数
拼接起来的数字可能会有前导 0，最后结果不需要去掉前导 0

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/ba-shu-zu-pai-cheng-zui-xiao-de-shu-lcof)
*/

// 更简单的写法
func makeMinNum2(_ nums: [Int]) -> String {
    let sortedNums = nums.sorted {
        "\($0)\($1)" < "\($1)\($0)"
    }
    
    return sortedNums
        .map(String.init)
        .joined()
}


func makeMinNum(_ nums: [Int]) -> String {
    guard nums.isEmpty == false else {
        return "0"
    }
    
    /**
     按位对比进行排序
     数字的第一位开始比较从小到大
     类似冒泡
     */
    var nums = nums
    
    // 冒泡不对
//    for j in nums.indices {
//        let vj = nums[j]
//        for i in 1..<nums.count {
//            if isSmaller(nums[i], vj) {
//                nums.swapAt(j, i)
//            }
//        }
//    }
    
    for j in nums.indices {
        for i in (j+1)..<nums.count {
            if isSmaller(nums[i], nums[j]) {
                nums.swapAt(j, i)
            }
        }
    }
    
//    func isSmaller(_ a: Int, _ b: Int) -> Bool {// 可能超出范围
//        guard let ab = Int("\(a)\(b)"), let ba = Int("\(b)\(a)") else {
//            return false
//        }
//        return ab < ba
//    }
    
    // 应该直接比较字符串
    func isSmaller(_ a: Int, _ b: Int) -> Bool {
        let ab = "\(a)\(b)"
        let ba = "\(b)\(a)"
        return ab < ba
    }
    
    // 不对 判断 a+b < b+a 就行了
//    func isSmallerX(_ a: Int, _ b: Int) -> Bool {
//        let aDigArr = Array("\(a)").map({ Int(String($0)) ?? 0 }),
//            bDigArr = Array("\(b)").map({ Int(String($0)) ?? 0 })
//        var pa = 0, pb = 0
//        
//        while pa < aDigArr.count, pb < bDigArr.count {
//            let va = aDigArr[pa], vb = bDigArr[pb]
//            if va < vb {
//                return true
//            }
//            else if va > vb {
//                return false
//            }
//            else if va == vb {
//                if pa + 1 < aDigArr.count, pb + 1 < bDigArr.count {
//                    pa += 1
//                    pb += 1
//                }
//                else if aDigArr.count > bDigArr.count {
//                    return aDigArr[pa + 1] < vb
//                }
//                else if aDigArr.count < bDigArr.count {
//                    return va < bDigArr[pb + 1]
//                }
//            }
//        }
//        
//        return false
//    }
    
    return nums.map({"\($0)"}).joined()
}

/*:
## 题目解析

这道题不是按照数字本身的大小排序，而是要决定两个数字拼接时谁应该放在前面。

### 比较规则

对于两个数字 `a` 和 `b`，分别拼接：

```text
ab
ba
```

如果：

```text
ab < ba
```

就说明 `a` 应该排在 `b` 前面。

例如：

```text
a = 3
b = 30
```

比较：

```text
ab = 330
ba = 303
```

因为 `303 < 330`，所以 `30` 应该排在 `3` 前面。

这就是代码中 `isSmaller` 的作用：

```swift
let ab = "\\(a)\\(b)"
let ba = "\\(b)\\(a)"
return ab < ba
```

### 为什么不能转换成 `Int`

拼接后的结果可能非常大，例如多个大数字拼接后会超过 `Int` 的取值范围。因此应该直接比较字符串，而不是：

```swift
Int("\\(a)\\(b)")
```

题目最终也要求返回字符串，直接使用字符串比较更加安全。

### 当前排序过程

当前代码使用的是部分选择排序：

```swift
for j in nums.indices {
    for i in (j + 1)..<nums.count {
        if isSmaller(nums[i], nums[j]) {
            nums.swapAt(j, i)
        }
    }
}
```

- 第 `j` 轮确定第 `j` 个位置应该放哪个数字。
- 如果后面的数字与当前数字相比更适合排在前面，就交换它们。
- 所有位置确定后，再把数字依次拼接起来。

这里的排序方式更接近**选择排序**，不是冒泡排序。

### 为什么最后直接拼接

排序规则已经保证任意相邻数字都满足“前后拼接结果更小”，因此按照排序后的顺序直接拼接，就能得到所有排列中的最小结果：

```swift
return nums.map(String.init).joined()
```

例如：

```text
[3, 30, 34, 5, 9]
```

排序后：

```text
[30, 3, 34, 5, 9]
```

拼接结果：

```text
3033459
```

### 边界情况

- 数组为空时返回 `"0"`。
- 数组中全是 `0` 时，按照题目要求保留前导零，例如返回 `"000"`。
- 不需要把最终结果转换为整数，因为结果可能超出整数范围。

### 复杂度

- 当前选择排序时间复杂度：`O(n²)`。
- 额外空间复杂度：`O(1)`，不计算返回字符串。
- 如果改用系统排序，时间复杂度可以优化为 `O(n log n)`。
*/

//: [下一题](@next)
