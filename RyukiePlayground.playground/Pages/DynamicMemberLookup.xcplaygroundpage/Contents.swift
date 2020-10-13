//: [Previous](@previous)

import Foundation

@dynamicMemberLookup
struct Ryukie {
    subscript(dynamicMember member: String) -> String {
        let properties = ["nickname": "Wang", "city": ""]
        return properties[member, default: "undefined"]
    }
}

let r = Ryukie()
print(r.name)
print(r.nickname)
print(r.city)

//: [Next](@next)
