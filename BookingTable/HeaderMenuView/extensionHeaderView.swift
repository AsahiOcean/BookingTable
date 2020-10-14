import UIKit

extension HeaderView {
    internal func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setNeedsDisplay()
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        self.mainGradientBackground()
        
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
            animation.fromValue = [#colorLiteral(red: 0.7529411765, green: 0.6745098039, blue: 0.7803921569, alpha: 1).cgColor, #colorLiteral(red: 0.5176470588, green: 0.4784313725, blue: 0.5803921569, alpha: 1).cgColor]
            animation.toValue = [#colorLiteral(red: 0.5176470588, green: 0.4784313725, blue: 0.5803921569, alpha: 1).cgColor, #colorLiteral(red: 0.7529411765, green: 0.6745098039, blue: 0.7803921569, alpha: 1).cgColor]
            animation.duration = 1.0
            animation.autoreverses = true
            animation.repeatCount = .infinity

            gradient.add(animation, forKey: "gradient_animation")
            self.layer.addSublayer(gradient)
        }
    }
}
