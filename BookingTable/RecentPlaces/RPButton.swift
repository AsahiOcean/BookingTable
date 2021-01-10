import UIKit

class RPButton: UIButton {
    
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
    
    func setIcon(_ name: String, _ tintColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), _ _frame: CGRect? = nil, _ scaleX: CGFloat = 0.5) {
        let iconView = UIImageView()
        if let frame = _frame {
            iconView.layer.frame = frame
        } else {
            iconView.layer.frame.size = CGSize(width: bounds.width*scaleX, height: bounds.height*scaleX)
            iconView.center = center
        }
        iconView.image = UIImage(named: name) != nil ? UIImage(named: name) : UIImage(systemName: name, withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        addSubview(iconView)
    }
    
    func gradientSetup(_ uiColors: [UIColor], _ animated: Bool, dur: CFTimeInterval = 3.0) {
        
        var cgColors: [CGColor] = []
        for color in uiColors { cgColors.append(color.cgColor) }
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = cgColors
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.frame = self.bounds
        gradient.drawsAsynchronously = true
        
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
    
    fileprivate func setup() {
        clipsToBounds = true
        isUserInteractionEnabled = true
        layer.cornerRadius = (bounds.width/10)*2
        addTarget(self,
                  action: #selector(animateDown),
                  for: [.touchDown, .touchDragEnter])
        addTarget(self,
                  action: #selector(animateUp),
                  for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
            setup()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
}
