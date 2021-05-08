//: [Previous](@previous)
/*:
 # 20. Valid Parentheses
 
 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 An input string is valid if:

 Open brackets must be closed by the same type of brackets.
 Open brackets must be closed in the correct order.
 */

struct Stack {
      private var arr: [String] = []
      mutating func push(_ str: String) {
        guard !str.isEmpty else {return}
        arr.append(str)
      }
      mutating func pop() -> String? {
        arr.popLast()
      }
      func peek() -> String? {
        guard !arr.isEmpty else { return nil }
        return arr[arr.count - 1]
      }
      func isEmpty() -> Bool {
        arr.isEmpty
      }
}
class Solution {
    func isValid(_ s: String) -> Bool {
        var stack = Stack()
        for char in s {
          guard let peeked = stack.peek() else {
            stack.push(String(char))
            continue
          }
          if char == "}", peeked == "{" {
            stack.pop()
          } else if char == "]", peeked == "[" {
            stack.pop()
          } else if char == ")", peeked == "(" {
            stack.pop()
          } else {
            stack.push(String(char))
          }
        }
        return stack.isEmpty()
    }
}

//: [Next](@next)
