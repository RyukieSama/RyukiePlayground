//: [Previous](@previous)

/*:
 # 
 ## 这三种权限分别是：
 
 * private 私有的
 
 在哪里写的，就在哪里用。无论是类、变量、常量还是函数，一旦被标记为私有的，就只能在定义他们的源文件里使用，不能为别的文件所用。
 
 * internal 内部的
 
 标记为internal的代码块，在整个应用（App bundle）或者框架（framework）的范围内都是可以访问的。
 
 * public 公开的
 
 标记为public的代码块一般用来建立API，这是最开放的权限，使得任何人只要导入这个模块，都可以访问使用。
 
 
 > 除了可以给整个声明设权限，Swift还允许大家在需要的时候，把某个属性（property）的取值权限比赋值权限设得更加开放。
 
 */

import Foundation

struct AccessItem {
    public private(set) var name: String {
        didSet {
            print("Name changed to \(name) from \(oldValue)")
        }
    }
    
    init() {
        name = "OldName"
    }
    
    // 为了能够在实例方法中修改属性值，可以在方法定义前添加关键字mutating
    mutating func changeName(newName: String) {
        name = newName
    }
}

var item = AccessItem()

//item.name = "Ryukie" // Error

item.changeName(newName: "Ryukie")


//: [Next](@next)
