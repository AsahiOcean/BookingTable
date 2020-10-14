import UIKit

public class HeaderView: UIView {
    
    var menuButton: UIButton!
    var _frame: CGRect!
    
    public override init(frame: CGRect) {
        let X: CGFloat = frame.minX == .zero ? UIScreen.main.bounds.minX : frame.minX
        let Y: CGFloat = frame.minY == .zero ? UIScreen.main.bounds.minY : frame.minY
        let W: CGFloat = frame.width == .zero ? UIScreen.main.bounds.width : frame.width
        let H: CGFloat = frame.height == .zero ? UIScreen.main.bounds.height / 10 : frame.height
        
        self._frame = CGRect(x: X, y: Y, width: W, height: H)
        
        super.init(frame: _frame)
        self.setupView()
        self.layer.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: _frame.minX, y: _frame.minY))
//        path.addLine(to: CGPoint(x: 200, y: 0))
//        path.addLine(to: CGPoint(x: 200, y: 200))
//        path.addLine(to: CGPoint(x: 0, y: 200))
//        path.addLine(to: CGPoint(x: 0, y: 0))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.orange.cgColor
        //shapeLayer.strokeColor = UIColor.black.cgColor
        //shapeLayer.lineWidth = 3
        self.layer.addSublayer(shapeLayer)
    }
        
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
