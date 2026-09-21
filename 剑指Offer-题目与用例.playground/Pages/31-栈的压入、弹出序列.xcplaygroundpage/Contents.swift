//: [上一题](@previous)


//func isPop(pushed: [Int], popped: [Int]) -> Bool {
//    // 要还原过程，看结果是否匹配
//    guard pushed.count == popped.count else { return false }
//    if pushed.isEmpty, popped.isEmpty { return true }
//    var tempPush: [Int] = []
//    var pushIdx = 0, popIdx = 0 // 从push 开始还原，遇到和 pop first 相同的就 pop
//    
//    while pushIdx < pushed.count, popIdx < popped.count {
//        let val = pushed[pushIdx]
//        tempPush.append(val)
//        
//        if val == popped[popIdx] {
//            tempPush.removeLast()
//            popIdx += 1
//        }
//        else {
//            pushIdx += 1
//        }
//    }
//    
//    return tempPush.isEmpty && popIdx == popped.count
//}


func isPop(pushed: [Int], popped: [Int]) -> Bool {
    guard pushed.count == popped.count else {
        return false
    }
    
    var stack: [Int] = []
    var popIdx = 0
    
    for value in pushed {
        stack.append(value)
        
        while let top = stack.last,
              popIdx < popped.count,
              top == popped[popIdx] {
            stack.removeLast()
            popIdx += 1
        }
    }
    
    return stack.isEmpty && popIdx == popped.count
}


/*:
## 辅助栈模拟解析

### 变量含义

- `stack`：模拟真实的栈，保存已经压入但还没有弹出的元素。
- `value`：当前正在处理的压入元素。
- `popIdx`：当前期待的弹出序列下标。

### 操作流程

外层循环依次处理 `pushed` 中的每个元素：

```swift
stack.append(value)
```

每压入一个元素后，检查栈顶是否等于下一个期待弹出的元素。如果相等，就持续弹出：

```swift
while let top = tempPush.last,
      popIdx < popped.count,
      top == popped[popIdx] {
    tempPush.removeLast()
    popIdx += 1
}
```

这里必须使用内层 `while`，因为一次压栈后，可能连续弹出多个元素。例如弹出 `4` 后，栈顶可能马上又变成 `3`，如果 `popped` 的下一个值也是 `3`，就要继续弹出。

### 示例

```text
pushed = [1,2,3,4,5]
popped = [4,5,3,2,1]
```

模拟过程：

```text
push 1 → 栈 [1]
push 2 → 栈 [1,2]
push 3 → 栈 [1,2,3]
push 4 → 栈 [1,2,3,4] → pop 4
push 5 → 栈 [1,2,3,5] → pop 5、3、2、1
```

最后辅助栈为空，并且 `popIdx` 已经处理完 `popped`，说明序列合法。

### 最终判断

```swift
return stack.isEmpty && popIdx == popped.count
```

- `stack` 为空：所有压入的元素都成功弹出。
- `popIdx == popped.count`：弹出序列中的所有元素都匹配成功。

### 复杂度

- 时间复杂度：`O(n)`，每个元素最多入栈一次、出栈一次。
- 空间复杂度：`O(n)`，来自辅助栈 `stack`。
*/

//: [下一题](@next)
