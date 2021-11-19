//: [Previous](@previous)

import Foundation

struct WeakBox<Element: AnyObject> {
    private(set) weak var value: Element?
    
    init(value: Element) {
        self.value = value
    }
}
struct WeakArray<Element: AnyObject>: Collection {
    // MARK: -
    private let items: [WeakBox<Element>]
    var startIndex: Int { items.startIndex }
    var endIndex: Int { items.endIndex }
    // MARK: -
    init(elements: [Element]) {
        self.items = elements.map { WeakBox(value: $0) }
    }
    
    subscript(position: Int) -> Element? {
        items[position].value
    }
    
    func index(after i: Int) -> Int {
        items.index(after: i)
    }
}
//: [Next](@next)
