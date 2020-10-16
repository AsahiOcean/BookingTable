import UIKit

extension HeaderView {
    
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
    
    internal func menuButton() {
        let button = UIButton()
        //button.setTitle("Menu", for: .normal)
        
        let icon = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(#colorLiteral(red: 0.6633401113, green: 0.5, blue: 0, alpha: 1), renderingMode: .alwaysOriginal).scaleX(1.75)
        
        button.setImage(icon, for: .normal)
                
        button.layer.bounds.size = CGSize(
            width: self.bounds.height/2,
            height: self.bounds.height/2)
                
        button.center = CGPoint(
            x: self.bounds.width/10,
            y: self.bounds.height - (button.frame.height * 0.75))
        
        self.addSubview(button)
    }
    
    internal func setupView() {
        self._frame = self.frame
        
//        translatesAutoresizingMaskIntoConstraints = false
//        setNeedsDisplay()
//        setNeedsLayout()
//        layoutIfNeeded()
//        layer.masksToBounds = true
        clipsToBounds = true // for cornerRadius
        layer.cornerRadius = 5.0
        
        mainGradientBackground()
        menuButton()
    }
}
