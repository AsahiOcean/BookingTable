import UIKit

final class HeaderView: UIView {

    var button: HeaderViewButton!
    
    public var gradientColors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor, #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor]
        
    fileprivate func animationGradient(_ frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.colors = gradientColors
        gradient.frame = frame
        gradient.locations =  [-1.0, 2.0]
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientColors
        animation.toValue = gradientColors.revers()
        animation.duration = 3.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: nil)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    fileprivate func setupView() {
        layoutIfNeeded()
        clipsToBounds = true // for cornerRadius
        layer.cornerRadius = 5
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        animationGradient(frame)
        
        button = HeaderViewButton(frame: CGRect(
                                    x: frame.width * 0.025,
                                    y: frame.height * 0.25,
                                    width: frame.height * 0.8,
                                    height: frame.height * 0.8))
        self.addSubview(button)
    }
        
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
}
