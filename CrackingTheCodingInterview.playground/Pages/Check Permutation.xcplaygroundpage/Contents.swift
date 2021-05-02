//: [Previous](@previous)
/*:
 
 # Check Permutation
 
 Given two strings,write a method to decide if one is a permutation of the
 other.
 */
import Foundation

extension String {
    func isPermutation(of str: String) -> Bool {
        guard count > 0, str.count > 0 else { return false }
        var dict: [Character: Int] = [:]
        for char in self {
            dict[char, default: 0] += 1
        }
        for char in str {
            if let val = dict[char], val > 0 {
                dict[char] = val - 1
            } else {
                return false
            }
        }
        return dict.values.allSatisfy { $0 == 0 }
    }
}

"malipdron".isPermutation(of: "palindrom")

//: [Next](@next)
