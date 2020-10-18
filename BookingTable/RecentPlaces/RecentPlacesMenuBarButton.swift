import UIKit

final class HeaderViewButton: UIButton {

    var icon: UIImage!
    
    override init(frame: CGRect) {
        let X: CGFloat = frame.minX == .zero ? UIScreen.main.bounds.minX : frame.minX
        let Y: CGFloat = frame.minY == .zero ? UIScreen.main.bounds.minY : frame.minY
        let W: CGFloat = frame.width == .zero ? UIScreen.main.bounds.width : frame.width
        let H: CGFloat = frame.height == .zero ? UIScreen.main.bounds.height / 10 : frame.height
        
        super.init(frame: CGRect(x: X, y: Y, width: W, height: H))
        
        let iconView = UIImageView()
        iconView.layer.frame = CGRect(
            x: self.frame.minX,
            y: self.frame.minY,
            width: self.frame.width / 2,
            height: self.frame.height / 2)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isUserInteractionEnabled = false
        iconView.isExclusiveTouch = false
        iconView.clipsToBounds = true
        iconView.layer.zPosition = self.layer.zPosition + 1
        iconView.image = UIImage(
            systemName: "line.horizontal.3",
            withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(#colorLiteral(red: 0.6633401113, green: 0.5, blue: 0, alpha: 1), renderingMode: .alwaysOriginal).scaleX(1.75)
        iconView.center = self.center
        //self.addSubview(iconView)
        
        self.icon = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(#colorLiteral(red: 0.6633401113, green: 0.5, blue: 0, alpha: 1), renderingMode: .alwaysOriginal).scaleX(1.75)
        
        self.setImage(self.icon, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
}
