////: [Previous](@previous)
//
//import Foundation
//
//protocol AnimeProtocol {
//
//}
//
//var assicateValueKey = "assKey"
//
//extension AnimeProtocol {
//    var assicateValue: String? {
//        get {
//            return objc_getAssociatedObject(self, &assicateValueKey) as? String
//        }
//        set {
//            objc_setAssociatedObject(self, &assicateValueKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//}
//
//struct Anime: AnimeProtocol {
//
//}
//
//var ani = Anime()
//ani.assicateValue = "Ass"
//print("\(String(describing: ani.assicateValue))")
//
////: [Next](@next)
