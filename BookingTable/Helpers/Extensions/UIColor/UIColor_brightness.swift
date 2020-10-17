import UIKit

public extension UIColor {
    func brightness(_ value: CGFloat) -> UIColor {
        var H: CGFloat = 0, S: CGFloat = 0, B: CGFloat = 0, A: CGFloat = 0
        
        if getHue(&H, saturation: &S, brightness: &B, alpha: &A) {
            B += (value - 1.0)
            B = max(min(B, 1.0), 0.0)
            
            return UIColor(hue: H, saturation: S, brightness: B, alpha: A)
        }
        
        return self
    }
}
