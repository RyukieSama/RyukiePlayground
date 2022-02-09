//: [Previous](@previous)

func bubbleSortA(nums: [Int]) -> [Int] {
    var nums = nums
    let count = nums.count
    
    for i in 0..<count {
        for j in (i + 1)..<count {
            if nums[i] > nums[j] {
                nums.swapAt(i, j)
            }
        }
    }
    
    return nums
}

func bubbleSortB(nums: [Int]) -> [Int] {
    var nums = nums
    let count = nums.count
    var last: Int?
    for i in 0..<count {
        if let l = last {
            
        }
        else {
            last = nums[i]
        }
        
        for j in (i + 1)..<count {
            if nums[i] > nums[j] {
                nums.swapAt(i, j)
            }
        }
    }
    
    return nums
}

func bubbleSortC(nums: [Int]) -> [Int] {
    var nums = nums
    let count = nums.count
    return nums
}

let numbers: [Int] = [3, 6, 8, 5, 7, 6, 2, 5, 8, 5, 5, 2, 4, 1, 5]

bubbleSortA(nums: numbers)

//: [Next](@next)
