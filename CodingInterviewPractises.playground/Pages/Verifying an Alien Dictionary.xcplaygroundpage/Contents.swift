//: [Previous](@previous)
/*:
 # 953. Verifying an Alien Dictionary
 
 In an alien language, surprisingly they also use english lowercase letters, but possibly in a different order. The order of the alphabet is some permutation of lowercase letters.

 Given a sequence of words written in the alien language, and the order of the alphabet, return true if and only if the given words are sorted lexicographicaly in this alien language.
 
 */
import Foundation

extension String {
    subscript(_ offset: Int) -> Element {
        get {
            self[index(startIndex, offsetBy: offset)]
        }
    }
}

class Solution {
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        var orderDict: [Character: Int] = [:] //h 1, l: 2, a: 3,
        for i in 0..<order.count {
            let key = order[i]
            orderDict[key] = i
        }
        for i in 0..<(words.count - 1) {
            let str1 = words[i]
            let str2 = words[i+1]
            
            let isPairSorted = compare(str1:str1, str2:str2, orderDict:orderDict)
            if !isPairSorted { return false }
        }
        
        return true
    }
    
    func compare(str1: String, str2: String, orderDict:[Character:Int]) -> Bool {
        for (chr1, chr2) in zip(str1, str2) {
            guard let ind1 = orderDict[chr1], let ind2 = orderDict[chr2] else {
                fatalError("Something went wrong")
            }
            if ind1 > ind2 {
                return false
            } else if ind2 > ind1 {
                return true
            }
        }

        if str1.count > str2.count {
            return false
        }
        return true
    }
}
//: [Next](@next)
