//: [Previous](@previous)

/*:
 Hit test implementation
 */
import UIKit

extension UIView {
    func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard
            isHidden,
            isUserInteractionEnabled,
            alpha >= 0.01
        else {
            return nil
        }
        
        var hitView: UIView? = self
        
        if !self.point(inside: point, with: event) {
            if clipsToBounds {
                return nil
            } else {
                hitView = nil
            }
        }

        for subview in subviews.reversed() {
            let translatedPoint = subview.convert(point, from: self)
            if let _ = subview.hitTest(translatedPoint, with: event) {
                return subview
            }
        }
        return hitView
    }
}


//: [Next](@next)
