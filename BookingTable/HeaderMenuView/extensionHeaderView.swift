import UIKit

extension HeaderView {
    internal func setupView() {
        self._frame = self.frame
        
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.setNeedsDisplay()
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//        self.layer.masksToBounds = true
        self.clipsToBounds = true // for cornerRadius
        self.layer.cornerRadius = 5.0
        
        self.mainGradientBackground()
        self.menuButton()
    }
    
    internal func mainGradientBackground() {
        let gradientDispatch_background = DispatchQueue(label: "com.gradientDispatch.background", qos: .background)
        gradientDispatch_background.async {
            let gradient = CAGradientLayer()
            gradient.colors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).cgColor]
            gradient.frame = CGRect(
                x: self._frame.minX,
                y: self._frame.minY,
                width: self._frame.width,
                height: self._frame.height)
            gradient.locations =  [-0.5, 1.5]
            
            let animation = CABasicAnimation(keyPath: "colors")
            animation.fromValue = [#colorLiteral(red: 0.1254901961, green: 0.3137254902, blue: 0.2117647059, alpha: 1).cgColor, #colorLiteral(red: 0.1254901961, green: 0.2352941176, blue: 0.2117647059, alpha: 1).cgColor]
            animation.toValue = [#colorLiteral(red: 0.1411764706, green: 0.1960784314, blue: 0.1960784314, alpha: 1).cgColor, #colorLiteral(red: 0.1254901961, green: 0.3137254902, blue: 0.2117647059, alpha: 1).cgColor]
            animation.duration = 3.0
            animation.autoreverses = true
            animation.repeatCount = .infinity

            gradient.add(animation, forKey: "gradient_animation")
            self.layer.addSublayer(gradient)
        }
    }
}
