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
        
        if !self.point(inside: point, with: event) {
            return nil
        }
        
        var hitFlag: Bool = false
        var hitView: UIView? = nil
        var children: [UIView] = []
        children.append(contentsOf:subviews)
        
        while !hitFlag || !children.isEmpty {
            guard let childToConsider = children.popLast() else {
                continue
            }
            if let hv = childToConsider.hitTest(point, with: event) {
                hitFlag = true
                hitView = hv
            }
            children.append(contentsOf: childToConsider.subviews)
        }
        
        return hitView
    }
}
