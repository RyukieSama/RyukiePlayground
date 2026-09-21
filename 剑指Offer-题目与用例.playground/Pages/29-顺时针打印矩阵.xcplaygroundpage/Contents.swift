//: [上一题](@previous)

/*:
# 29-顺时针打印矩阵

## 题目

输入一个矩阵，按照从外向里以顺时针的顺序依次打印出每一个数字。

## 用例 1

**输入：** matrix = [[1,2,3],[4,5,6],[7,8,9]]
**输出：** [1,2,3,6,9,8,7,4,5]
## 用例 2

**输入：** matrix = [[1,2,3,4],[5,6,7,8],[9,10,11,12]]
**输出：** [1,2,3,4,8,12,11,10,9,5,6,7]

## 约束

0 <= matrix.length <= 100
0 <= matrix[i].length <= 100
注意：本题与主站 54 题相同：https://leetcode-cn.com/problems/spiral-matrix/

## 来源

[LeetCode 原题](https://leetcode-cn.com/problems/spiral-matrix/)
*/

func printGrid(grid: [[Int]]) -> [Int] {
    enum DIR {
        case right
        case down
        case left
        case up
    }
    
    var res: [Int] = [], x = 0, y = 0, dirction: DIR = .right
    
    guard
        grid.isEmpty == false,
        let fl = grid.first,
        fl.isEmpty == false
    else {
        return res
    }
    
    let width = fl.count, height = grid.count
    
    var step: [[Bool]] = Array(repeating: Array(repeating: false, count: fl.count), count: grid.count)
    step[0][0] = true
    res.append(grid[0][0])
    
    while let nextStep = next() {
        res.append(grid[nextStep.1][nextStep.0])
    }
    
    func next(_ change: Bool = false) -> (Int, Int)? {
        guard
            x >= 0,
            x < width,
            y >= 0,
            y < height
        else {
            return nil
        }
        
        // 注意不要无限的转方向死循环了，只变一次方向，变不了就说明结束了
        switch dirction {
        case .right:
            if x + 1 < width, step[y][x+1] == false {
                x += 1
                step[y][x] = true
            }
            else {
                dirction = .down
                return change ? nil : next(true)
            }
        case .down:
            if y + 1 < height, step[y + 1][x] == false {
                y += 1
                step[y][x] = true
            }
            else {
                dirction = .left
                return change ? nil : next(true)
            }
        case .left:
            if x - 1 >= 0, step[y][x-1] == false {
                x -= 1
                step[y][x] = true
            }
            else {
                dirction = .up
                return change ? nil : next(true)
            }
        case .up:
            if y - 1 >= 0, step[y-1][x] == false {
                y -= 1
                step[y][x] = true
            }
            else {
                dirction = .right
                return change ? nil : next(true)
            }
        }
        
        return (x, y)
    }
    
    
    return res
}

/*:
## 顺时针遍历解析

### 核心思路

从左上角开始，按照固定方向依次访问矩阵：

```text
向右 → 向下 → 向左 → 向上 → 向右 ...
```

当下一个位置越界，或者已经访问过时，就顺时针切换到下一个方向。

### `step` 的作用

```swift
var step = Array(
    repeating: Array(repeating: false, count: width),
    count: height
)
```

`step[y][x]` 表示当前位置是否已经访问过。这样可以避免在进入内层区域时重复访问外层节点。

访问一个位置后立即标记：

```swift
step[y][x] = true
```

### `next` 的方向切换

`next` 每次只负责寻找下一个可访问位置：

1. 当前方向可以继续走：移动坐标并标记。
2. 当前方向越界或遇到已访问位置：切换到下一个方向。
3. 如果切换后仍然不能移动，说明没有可访问位置，返回 `nil`。

`change` 参数用于限制一次调用中最多切换一次方向，避免四个方向都不可用时在方向之间无限递归。

### 初始位置和终止条件

矩阵非空时，先把左上角加入结果：

```swift
step[0][0] = true
res.append(grid[0][0])
```

之后不断获取下一个位置，直到 `next()` 返回 `nil`。也可以使用结果数量作为终止条件：

```swift
while res.count < width * height,
      let nextStep = next() {
    res.append(grid[nextStep.1][nextStep.0])
}
```

### 边界情况

- 空矩阵：直接返回空数组。
- 空行：直接返回空数组。
- 单行矩阵：只会向右遍历。
- 单列矩阵：只会向下遍历。
- 只有一个元素：加入一次后结束。

### 复杂度

- 时间复杂度：`O(m × n)`，每个位置最多访问一次。
- 空间复杂度：`O(m × n)`，来自 `step` 访问标记数组。
*/

//: [下一题](@next)
