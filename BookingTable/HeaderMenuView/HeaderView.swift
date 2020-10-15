import UIKit

public class HeaderView: UIView {
    
    static let shared = HeaderView()
    internal var _frame: CGRect!
    
    public override init(frame: CGRect) {
        let X: CGFloat = frame.minX == .zero ? UIScreen.main.bounds.minX : frame.minX
        let Y: CGFloat = frame.minY == .zero ? UIScreen.main.bounds.minY : frame.minY
        let W: CGFloat = frame.width == .zero ? UIScreen.main.bounds.width : frame.width
        let H: CGFloat = frame.height == .zero ? UIScreen.main.bounds.height / 10 : frame.height
        
        super.init(frame: CGRect(x: X, y: Y, width: W, height: H))
        self.setupView()
    }
        
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
