import UIKit

final class HeaderView: UIView {

    private var gradient: CAGradientLayer = CAGradientLayer()
    private var button: HeaderViewButton!
    
    private var cgColors: [CGColor] = []
    public var gradientColors: [UIColor] = [] {
        didSet {
            for color in self.gradientColors {
                self.cgColors.append(color.cgColor)
            }
        }
    }
    //MARK: -- Gradient Settings
    // Gradient Layer
    fileprivate func layerGradient(_ gl: CAGradientLayer, _ cgColors: [CGColor], _ completion: @escaping (CAGradientLayer, [CGColor]) throws -> Void) {
        gl.colors = cgColors
        gl.frame = CGRect(origin: .zero, size: frame.size)
        gl.locations =  [-1.0, 2.0]
        self.layer.insertSublayer(gl, at: 0)
        try? completion(gl, cgColors)
    }
    // Gradient Animation
    fileprivate func animationGradient(_ gl: CAGradientLayer, _ cgColors: [CGColor]) {
        let dispatchQueue = DispatchQueue(label: "animationGradient.dispatchQueue", qos: .userInteractive)
        dispatchQueue.async {
            let animation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = cgColors
            animation.toValue = cgColors.revers()
            animation.duration = 3.0
            animation.autoreverses = true
            animation.repeatCount = .infinity
            gl.add(animation, forKey: nil)
        }
    }
    
    //MARK: -- HeaderViewButton
    fileprivate func buttonConfig() {
        button = HeaderViewButton(frame: CGRect(
                                    x: frame.width * 0.025,
                                    y: frame.height * 0.25,
                                    width: frame.height * 0.8,
                                    height: frame.height * 0.8))
        addSubview(button)
    }
    
    fileprivate func setupView() {
        clipsToBounds = true // for cornerRadius
        layer.cornerRadius = 5
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        gradientColors = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
        layerGradient(gradient, cgColors, { gr,col in
            self.animationGradient(gr,col)
        })
        buttonConfig()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
        
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
}
