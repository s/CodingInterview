import Foundation
// Add any extra import statements you may need here

struct RotationalCipher {
    let backing: String

    func cipher(withRotationFactor: Int) -> String {
      guard
        withRotationFactor > 0,
        withRotationFactor % 26 > 0,
        let digitsLowerBound = "0".utf16.first,
        let digitsUpperBound = "9".utf16.first,
        let lowerAlphabetLowerBound = "a".utf16.first,
        let lowerAlphabetUpperBound = "z".utf16.first,
        let upperAlphabetLowerBound = "A".utf16.first,
        let upperAlphabetUpperBound = "Z".utf16.first
      else {
        return backing
      }
      
      let alphanumericSet = NSMutableCharacterSet.alphanumeric()
      let digitsSet = NSMutableCharacterSet.decimalDigits
      var returnStrChars: [Character] = []
      var newCharacterCode: UInt16
      let lettersCount: UInt16 = 26
      var normalizedRotationFactor: UInt16
      
      for char in backing.unicodeScalars {
        // if we can retrieve the utf16 character
        guard let charCode = char.utf16.first else {
          returnStrChars.append(Character(char))
          continue
        }
        
        guard alphanumericSet.characterIsMember(charCode) else {
          returnStrChars.append(Character(char))
          continue
        }
        let character = Character(UnicodeScalar(char))
        
        if digitsSet.contains(char) {
          normalizedRotationFactor = UInt16(withRotationFactor) % 10
          newCharacterCode = charCode + UInt16(normalizedRotationFactor)
          
          if newCharacterCode > digitsUpperBound {
            let mod: UInt16 = newCharacterCode % digitsUpperBound
            newCharacterCode = (digitsLowerBound + mod - 1)
          }
        } else {
          normalizedRotationFactor = UInt16(withRotationFactor) % 26
          newCharacterCode = charCode + UInt16(normalizedRotationFactor)
          
          if Character("a")...Character("z") ~= character {
            if newCharacterCode > lowerAlphabetUpperBound {
              let mod: UInt16 = newCharacterCode % lowerAlphabetUpperBound
              newCharacterCode = (lowerAlphabetLowerBound + mod - 1)
            }
          } else if Character("A")...Character("Z") ~= character {
            if newCharacterCode > upperAlphabetUpperBound {
              let mod: UInt16 = newCharacterCode % upperAlphabetUpperBound
              newCharacterCode = (upperAlphabetLowerBound + mod - 1)
            }
          }
        }
        
        if let scalar = UnicodeScalar(newCharacterCode) {
          returnStrChars.append(Character(scalar))
        }
      }

      return String(returnStrChars)
    }
}











// These are the tests we use to determine if the solution is correct.
// You can add your own at the bottom, but they are otherwise not editable!

private extension String {
    var characterArray: String {
        return "[\"\(self)\"]"
    }
}

private var testCaseNumber = 1;
 
private extension RotationalCipher {
    static func check(_ expectedValue: String, against output: String) {
        let rightTick = "\u{2713}";
        let wrongTick = "\u{2717}";
    
        let result = expectedValue == output
        if result {
            print("\(rightTick) Test #\(testCaseNumber)")
        } else {
            print("\(wrongTick) Test #\(testCaseNumber) Expected: \(expectedValue.characterArray) Your output: \(output.characterArray)")
        }
        testCaseNumber += 1
    }
}

let input1 = "All-convoYs-9-be:Alert1."
let expected1 = "Epp-gsrzsCw-3-fi:Epivx5."
let output1 = RotationalCipher(backing: input1).cipher(withRotationFactor: 4)
RotationalCipher.check(expected1, against: output1)

let input2 = "abcdZXYzxy-999.@"
let expected2 = "stuvRPQrpq-999.@"
let output2 = RotationalCipher(backing: input2).cipher(withRotationFactor: 200)
RotationalCipher.check(expected2, against: output2)

// Add your own test cases here
let input3 = "All-convoYs-9-be:Alert1."
let expected3 = "All-convoYs-9-be:Alert1."
let output3 = RotationalCipher(backing: input3).cipher(withRotationFactor: 26)
RotationalCipher.check(expected3, against: output3)
