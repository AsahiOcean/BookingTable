import UIKit

class RecentPlacesButton: UIButton {

    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                            button.transform = transform
                            for view in button.subviews {
                                view.transform = transform
                            }
        }, completion: nil)
    }
    
    func setIcon(_ name: String, _ tintColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), iconFrame: CGRect? = nil, scaleX: CGFloat = 1.0) {
        let iconView = UIImageView()
        if let frame = iconFrame {
            iconView.layer.frame = frame
        } else {
            iconView.layer.frame = CGRect(
                origin: .zero,
                size: CGSize(
                    width: self.frame.width * scaleX,
                    height: self.frame.height * scaleX
            ))
            iconView.center = self.center
        }
        iconView.isUserInteractionEnabled = false
        iconView.isExclusiveTouch = false
        iconView.clipsToBounds = true
        iconView.layer.zPosition = self.layer.zPosition + 1
        if (UIImage(named: name) != nil) {
            iconView.image = UIImage(named: name)
        } else {
            iconView.image = UIImage(
                systemName: name,
                withConfiguration: UIImage.SymbolConfiguration(
                    weight: .medium))?.withTintColor(tintColor,
                    renderingMode: .alwaysOriginal)
        }
        self.addSubview(iconView)
    }
    
    func gradientSetup(colors: [UIColor], _ animated: Bool, dur: CFTimeInterval = 3.0) {

        var cgColors: [CGColor] = []
        for color in colors { cgColors.append(color.cgColor) }

        let gradient: CAGradientLayer = CAGradientLayer()
            gradient.colors = cgColors
            gradient.cornerRadius = self.layer.cornerRadius
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 1, y: 0)
            gradient.frame = self.bounds

            if animated {
                let animation = CABasicAnimation(keyPath: "colors")
                animation.fromValue = cgColors
                animation.toValue = cgColors.revers()
                animation.duration = dur
                animation.autoreverses = true
                animation.repeatCount = .infinity
                gradient.add(animation, forKey: nil)
            }
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        isExclusiveTouch = true
        translatesAutoresizingMaskIntoConstraints = false
        layer.masksToBounds = true
        clipsToBounds = true
        layer.cornerRadius = CGFloat(16)
        
        self.addTarget(self,
                         action: #selector(animateDown),
                         for: [.touchDown, .touchDragEnter])
        self.addTarget(self,
                         action: #selector(animateUp),
                         for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
}
