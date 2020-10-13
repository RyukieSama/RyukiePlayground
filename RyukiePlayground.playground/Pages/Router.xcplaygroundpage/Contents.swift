//: Playground - noun: a place where people can play

import UIKit

protocol RouterProtocol {
    static func logMe(data : String)
}

class SuiRouter : NSObject,RouterProtocol {
    @objc static func pi() {
        print(self)
    }
    
    static func logMe(data: String) {
        print(data)
    }
}

SuiRouter.pi()

class Playground : NSObject {
    static var bundleVersion: String {
        let s = self.description().replacingOccurrences(of: ".Playground", with: "")
        return s
    }
//    static var bundleVersion: String {
//        let s = self.description.stringByReplacingOccurrencesOfString(".Playground", withString:"")
//        return s
//    }
}
let version = Playground.bundleVersion

class Actor {
    
    func haha() {
        let str = "\(version).SuiRouter"
        
        let cls = NSClassFromString(str) as? NSObject.Type

        print(cls as Any)

        guard cls != nil else {
            print("No")
            return
        }

        if cls!.init() is RouterProtocol {
            print("NSObject: \(cls!) is RouterProtocol")
//            let clsObj = cls as
////            cls?.perform(#selector(RouterProtocol.logMe(data:)))
//            let sel = #selector(cls.pi)
        } else {
            print("NoProtocol")
        }
    }
    
    var routers : [(String , AnyClass : RouterProtocol)]?
    
}

let ac = Actor()
ac.haha()

//ac.routers?.append(("Sui", SuiRouter.self))

