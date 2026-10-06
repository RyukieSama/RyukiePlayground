//: [上一题](@previous)

/*:
# 66-构建乘积数组

## 题目

给定一个数组 A[0,1,…,n-1]，请构建一个数组 B[0,1,…,n-1]，其中 B[i] 的值是数组 A 中除了下标 i 以外的元素的积, 即 B[i]=A[0]×A[1]×…×A[i-1]×A[i+1]×…×A[n-1]。

不能使用除法。

## 用例

**输入：** [1,2,3,4,5]

**输出：** [120,60,40,30,24]

## 提示

所有元素乘积之和不会溢出 32 位整数

a.length <= 100000

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/gou-jian-cheng-ji-shu-zu-lcof)
*/

func build20261006_2(_ nums: [Int]) -> [Int] {
    guard nums.isEmpty == false else {
        return []
    }
    var result: [Int] = Array(repeating: 1, count: nums.count)
    
    // 计算每个下标左侧的乘积
    var leftVal = 1
    for idx in nums.indices {
        result[idx] = leftVal
        leftVal *= nums[idx]
    }
    
    // 计算每个下标右侧的乘积，要从最右开始累积
    var rightVal = 1
    for idx in nums.indices.reversed() {
        result[idx] *= rightVal
        rightVal *= nums[idx]
    }
    
    return result
}


// 时间复杂度太高，不好
func build20261006(_ nums: [Int]) -> [Int] {
    guard nums.isEmpty == false else {
        return []
    }
    var result: [Int] = []
    for j in nums.indices {
        var res = 1
        for i in nums.indices {
            if i != j {
                res *= nums[i]
            }
        }
        result.append(res)
    }
    return result
}


func build2(_ a: [Int]) -> [Int] {
    guard a.isEmpty == false else {
        return []
    }
    var res: [Int] = Array(repeating: 1, count: a.count)
    // 先计算每个元素左边的乘积
    var leftV = 1
    for i in a.indices {
        res[i] = leftV
        leftV *= a[i]
    }

    // 再计算每个元素右边的乘积
    var rightV = 1
    for i in a.indices.reversed() {
        res[i] *= rightV
        rightV *= a[i]
    }
    return res
}


func build(_ a: [Int]) -> [Int] {
    guard a.isEmpty == false else {
        return []
    }
    // B[i] = i 左边所有元素的乘积 × i 右边所有元素的乘积
    var res = Array(repeating: 1, count: a.count)
    
    // 第一次遍历：计算每个位置左边所有元素的乘积
    var leftProduct = 1
    for i in a.indices {
        // result[i] 先保存 i 左边所有元素的乘积
        res[i] = leftProduct
        leftProduct *= a[i]
    }
    
    // 第二次遍历：乘上每个位置右边所有元素的乘积
    var rightProduct = 1
    for i in a.indices.reversed() {
        // 再乘上 i 右边所有元素的乘积
        res[i] *= rightProduct
        rightProduct *= a[i]
    }
    
    return res
}


/*:
## 题目解析

对于每个位置 `i`，目标是计算：

`B[i] = A 中除了 A[i] 以外所有元素的乘积`

可以将它拆成两部分：

`B[i] = i 左边所有元素的乘积 × i 右边所有元素的乘积`

这样就不需要使用除法，也能正确处理数组中存在 `0` 的情况。

### 第一次遍历：记录左侧乘积

从左到右遍历数组。`leftProduct` 表示当前下标左边所有元素的乘积，先把它放入 `result[i]`，再把当前元素乘进去，供下一个位置使用。

对于 `[1,2,3,4,5]`，第一次遍历后得到：

```text
result = [1, 1, 2, 6, 24]
```

其中每个位置保存的都是它左边元素的乘积。没有左侧元素时，乘积取 `1`。

### 第二次遍历：乘上右侧乘积

从右到左遍历数组。`rightProduct` 表示当前下标右边所有元素的乘积，将它乘到 `result[i]` 中，再把当前元素乘进去，供左边的位置使用。

最终得到：

```text
[120, 60, 40, 30, 24]
```

### 为什么能处理 0

例如 `[1,2,0,4]`：

- `0` 所在位置的结果是左侧乘积 `1×2` 乘右侧乘积 `4`，得到 `8`；
- 其他位置的乘积都会包含 `0`，因此结果为 `0`。

整个过程没有除法，所以不会遇到除数为 `0` 的问题。

### 复杂度

- 时间复杂度：`O(n)`，数组被遍历两次。
- 额外空间复杂度：`O(1)`，只使用两个乘积变量；返回数组不计入额外空间。
*/
//: [下一题](@next)
