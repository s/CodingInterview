//: [Previous](@previous)

/*:
 # Is Unique
 Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?
 */

import Foundation

extension String {
    func hasUniqueCharacters() -> Bool {
        guard count > 0 else { return false }
        let set = Set(self)
        return set.count == self.count
    }
    
    func _hasUniqueCharacters() -> Bool {
        guard count > 0 else { return false }
        let sortedStr = sorted()
        for i in 0..<(sortedStr.count - 1) {
            if sortedStr[i] == sortedStr[i + 1] {
                return false
            }
        }
        return true
    }
}

let str = "abcda"
str._hasUniqueCharacters()


//: [Next](@next)
