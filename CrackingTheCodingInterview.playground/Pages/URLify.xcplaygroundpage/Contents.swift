//: [Previous](@previous)

/*:
 # URLify
 
 Write a method to replace all spaces in a string with '%20'. You may assume that the string has sufficient space at the end to hold the additional characters,and that you are given the "true" length of the string. (Note: If implementing in Java,please use a character array so that you can perform this operation in place.)
 
 Input: "Mr John Smith  ", 13
 
 Output: "Mr%20John%20Smith"
 */
import Foundation
import XCTest

extension String {
    subscript(_ offset: Int) -> Element {
        get {
            self[index(startIndex, offsetBy: offset)]
        }
        set {
            let lowerBound = index(startIndex, offsetBy: offset)
            let upperBound = index(startIndex, offsetBy: offset + 1)
            let range = lowerBound..<upperBound
            replaceSubrange(range, with: [newValue])
        }
    }

    func replaceAllSpaces(with str: String = "%20") -> String {
        replacingOccurrences(of: " ", with: str)
    }
    
    func _replaceAllSpaces(with str: String = "%20") -> String {
        var newStr = ""
        for char in self {
            if char == " " {
                newStr.append(str)
            } else {
                newStr.append(char)
            }
        }
        return newStr
    }
    
    mutating func __replaceAllSpaces(with str: String = "%20") {
        var cursor: Int = 0
        let initialCount = count
        var totalCount = count
        var replacementsCount: Int = 0
        while cursor < totalCount {
            if self[cursor] == " " {
                self[cursor] = "%"
                let nextIndex = index(startIndex, offsetBy: cursor + 1)
                self.insert(contentsOf: "20", at: nextIndex)
                totalCount += 2
                replacementsCount += 1
            }
            cursor += 1
        }
        removeLast(count - initialCount)
    }
}

assert("Hello there!".replaceAllSpaces() == "Hello%20there!")
assert("Hello there!"._replaceAllSpaces() == "Hello%20there!")
var lhs = "Mr John Smith    "
lhs.__replaceAllSpaces()
assert(lhs == "Mr%20John%20Smith")
//: [Next](@next)
