//: [上一题](@previous)

/*:
# 13-机器人的运动范围

## 题目

地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。

一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外），也不能进入行坐标和列坐标的数位之和大于k的格子。

例如，当k为18时，机器人能够进入方格 [35, 37] ，因为3+5+3+7=18。但它不能进入方格 [35, 38]，因为3+5+3+8=19。请问该机器人能够到达多少个格子？

## 用例 1

```C++
输入：m = 2, n = 3, k = 1
输出：3
```

## 用例 2

```C++
输入：m = 3, n = 1, k = 0
输出：1
```

## 提示

```C++
1 <= n,m <= 100
0 <= k <= 20
```

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof)
*/
func botGoGoGo(m: Int, n: Int, k: Int) -> Int {
    guard m > 0, n > 0 else { return 0 }
    guard k > 0 else { return 1 }
    var mark: [[Bool]] = Array(repeating: Array(repeating: false, count: n), count: m)
    var count = 0
    
    move(toX: 0, toY: 0)
    
    func move(toX: Int, toY: Int) {
        guard toX >= 0, toY >= 0, toX < n, toY < m else {
            return
        }
        if mark[toY][toX] == false, countDig(toX, toY) <= k {
            count += 1
            mark[toY][toX] = true
            
            move(toX: toX - 1, toY: toY)
            move(toX: toX + 1, toY: toY)
            move(toX: toX, toY: toY - 1)
            move(toX: toX, toY: toY + 1)
        }
    }
    
    return count
}

func countDig(_ x: Int, _ y: Int) -> Int {
    var sum = 0, x = x, y = y
    
    while x > 0 {
        sum += x % 10
        x /= 10
    }
    
    while y > 0 {
        sum += y % 10
        y /= 10
    }
    
    return sum
}

botGoGoGo(m: 2, n: 3, k: 1)

/*:
## 题目解析：DFS 搜索可达区域

机器人从 `(0, 0)` 出发，每次只能移动到上下左右相邻的格子。一个格子能进入的条件是：

```text
行坐标的数位和 + 列坐标的数位和 <= k
```

### 解题步骤

1. 从 `(0, 0)` 开始进行深度优先搜索（DFS）。
2. 每到一个格子，先判断是否越界、是否已经访问过，以及坐标数位和是否超过 `k`。
3. 当前格子合法时，将它标记为已访问，并将结果加一。
4. 继续搜索上、下、左、右四个方向。

### 为什么使用 `mark`

同一个格子可能从多个方向到达。如果不记录访问状态，就会重复统计，甚至在相邻格子之间反复搜索。

本题只需要统计所有可达格子，不需要寻找某一条特定路径。因此格子一旦访问过，就不需要在递归结束时取消标记。即使以后从另一个方向再次到达，也不会增加新的答案。

### 数位和计算

`countDig` 使用取模和整除提取每一位：

```swift
sum += x % 10
x /= 10
```

例如坐标 `(35, 37)` 的数位和为 `3 + 5 + 3 + 7 = 18`。

### 边界情况

- `m` 或 `n` 不合法时，没有可访问的格子，返回 `0`。
- `k == 0` 时，只有 `(0, 0)` 的数位和为 `0`，返回 `1`。
- 判断条件必须使用 `<= k`，因为题目允许数位和刚好等于 `k` 的格子。

### 复杂度

设网格大小为 `m × n`：

- 时间复杂度：`O(m × n)`，每个格子最多访问一次。
- 空间复杂度：`O(m × n)`，来自 `mark` 和最坏情况下的递归栈。
*/

//: [下一题](@next)
