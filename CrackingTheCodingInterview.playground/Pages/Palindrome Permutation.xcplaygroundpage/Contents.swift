//: [Previous](@previous)

/*:
 # Palindrome Permutation
 
 Given a string, write a function to check if it is a permutation of a palin­ drome. A palindrome is a word or phrase that is the same forwards and backwards. A permutation is a rearrangement of letters. The palindrome does not need to be limited to just dictionary words.
 
 ---
 Example
 
 Input: Tact Coa
 
 Output: True (permutations: "taco cat", "atco eta", etc.)
 */
import Foundation

extension String {
    func characterMap() -> [Character: Int] {
        var charMap: [Character: Int] = [:]
        let punctuations = NSMutableCharacterSet.punctuation()
        punctuations.formUnion(with: .symbols)
        punctuations.formUnion(with: .whitespacesAndNewlines)
        punctuations.formUnion(with: .illegalCharacters)
        
        for char in self {
            let lower = char.lowercased()

            guard let firstChar = lower.utf16.first else { continue }
            if !punctuations.characterIsMember(firstChar) {
                charMap[Character(lower), default: 0] += 1
            }
        }
        return charMap
    }
    func isPermutationOfAPalindrome() -> Bool {
        let filteredMap = characterMap().filter { $0.value % 2 != 0 }
        return filteredMap.count <= 1
    }
}

assert("Tact Coa".isPermutationOfAPalindrome() == true)
assert("_12 _21".isPermutationOfAPalindrome() == true)
assert("Maccam".isPermutationOfAPalindrome() == true)
assert("😟😆😟".isPermutationOfAPalindrome() == true)
assert("_!!@$%#%!Tenet".isPermutationOfAPalindrome() == true)
assert("Interstellar".isPermutationOfAPalindrome() == false)
//: [Next](@next)
