//: [Previous](@previous)

/*:
 # One Away
 
 There are three types of edits that can be performed on strings: insert a character, remove a character, or replace a character. Given two strings, write a function to check if they are one edit (or zero edits) away.
 
 Example
 
 pale, ple -> true
 
 pales, pale -> true
 
 pale, bale -> true
 
 pale, bake -> false
 */
import Foundation

extension String {
    
    subscript(_ offset: Int) -> Element {
        get {
            self[index(startIndex, offsetBy: offset)]
        }
        set {
            let lower = index(startIndex, offsetBy: offset)
            let upper = index(startIndex, offsetBy: offset)
            replaceSubrange(lower...upper, with: [newValue])
        }
    }
    
    func levenshteinDistance(from otherString: String) -> Int {
        guard !otherString.isEmpty else { return count }
        let rowCount = count + 1
        let colCount = otherString.count + 1
        var distanceMatrix = Array(repeating: Array(repeating: 0, count: colCount), count: rowCount)
        for i in 0..<rowCount {
            distanceMatrix[i][0] = i
        }
        
        for j in 0..<colCount {
            distanceMatrix[0][j] = j
        }
        
        for i in 1..<rowCount {
            for j in 1..<colCount {
                if self[i - 1] == otherString[j - 1] {
                    distanceMatrix[i][j] = distanceMatrix[i - 1][j - 1]
                } else {
                    let insertion = distanceMatrix[i][j - 1] + 1
                    let deletion = distanceMatrix[i - 1][j] + 1
                    let replacement = distanceMatrix[i - 1][j - 1] + 1
                    
                    distanceMatrix[i][j] = min(min(deletion, insertion), replacement)
                }
            }
        }
        return distanceMatrix[rowCount - 1][colCount - 1]
    }
    
    func isOneOperationAway(from otherStr: String) -> Bool {
        // if both are empty, then they're same
        if isEmpty && otherStr.isEmpty { return false }
        
        // if self is empty but other str not
        guard !isEmpty else { return otherStr.isEmpty }
        
        // if other str is empty but self is not
        guard !otherStr.isEmpty else { return isEmpty }
        let distance = levenshteinDistance(from: otherStr)
        return distance == 1
    }
}

assert("pale".isOneOperationAway(from: "ple"))
assert("pales".isOneOperationAway(from: "pale"))
assert("pale".isOneOperationAway(from: "bale"))
assert(!"pale".isOneOperationAway(from: "bake"))
assert("hello".isOneOperationAway(from: "helo"))
assert("hello".isOneOperationAway(from: "hell"))
assert("hello".isOneOperationAway(from: "sello"))
assert(!"hello".isOneOperationAway(from: ""))
assert(!"".isOneOperationAway(from: ""))
//: [Next](@next)
