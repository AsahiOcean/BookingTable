import UIKit

final class RecentPlaces: UIView {
    
    private var stackView: UIStackView!
    private var stackView_subviews: [UIView] = []
    private let cancelBtn = UIButton()
    private let infoBtn = UIButton()
    private let callBtn = UIButton()
    private let padding: CGFloat = 10.0
        
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
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
        
    fileprivate func buttonSetup(_ button: UIButton, _ clr: UIColor?, _ completion: @escaping (UIButton) throws -> Void){
        button.layer.frame = CGRect(
            x: frame.width * 0.825,
            y: frame.height / 10,
            width: frame.height / 4,
            height: frame.height / 4)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.isExclusiveTouch = true
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.layer.cornerRadius = CGFloat(16)
        
        button.addTarget(self,
                         action: #selector(animateDown),
                         for: [.touchDown, .touchDragEnter])
        button.addTarget(self,
                         action: #selector(animateUp),
                         for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        do {
            try completion(button)
            guard let color = clr else { return }
            button.layer.backgroundColor = color.cgColor
        } catch {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func buttonGradient(_ button: UIButton, _ gradient_color1: UIColor, _ gradient_color2: UIColor, _ completion: @escaping (UIButton) throws -> Void) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [
            gradient_color1.brightness(1.25).cgColor,
            gradient_color2.cgColor
        ]
        gradient.cornerRadius = button.layer.cornerRadius
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [
            gradient_color1.brightness(1.25).cgColor,
            gradient_color2.cgColor
        ]
        animation.toValue = [
            gradient_color2.cgColor,
            gradient_color1.brightness(1.25).cgColor
        ]
        animation.duration = 3.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: "gradient_animation")
        button.layer.insertSublayer(gradient, at: 0)
        gradient.frame = button.bounds
        do {
            try completion(button)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    fileprivate func buttonImageView(_ button: UIButton, _ imageSystemName: String, _ color: UIColor, _ completion: @escaping (UIButton) throws -> Void) {
        let iconView = UIImageView()
        iconView.layer.frame = CGRect(
            x: button.frame.minX,
            y: button.frame.minY,
            width: button.frame.width / 2,
            height: button.frame.height / 2)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.isUserInteractionEnabled = false
        iconView.isExclusiveTouch = false
        iconView.clipsToBounds = true
        iconView.layer.zPosition = button.layer.zPosition + 1
        iconView.image = UIImage(
            systemName: imageSystemName,
            withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(color, renderingMode: .alwaysOriginal)
        iconView.center = button.center
        self.addSubview(iconView)
        do {
            try completion(button)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func extensionButton(_ button: UIButton, _ imageSystemName: String, _ color1: UIColor, _ color2: UIColor, _ completion: @escaping (UIButton) throws -> Void) {
        
        self.buttonSetup(button, color1, { button in
            self.buttonGradient(button, color1, color2, { button in
                self.buttonImageView(button, imageSystemName, color2, {
                    button in
                    try? completion(button)
                })
            })
        })
    }
    
    fileprivate func buttonsPanel() {
        
        extensionButton(cancelBtn, "multiply", #colorLiteral(red: 0.7693968415, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.5192301869, green: 0, blue: 0, alpha: 1), { button in
            self.stackView_subviews.append(button)
        })

        extensionButton(infoBtn, "info.circle", #colorLiteral(red: 0.2414665818, green: 0.6734955907, blue: 0.9696385264, alpha: 1), #colorLiteral(red: 0.1318834424, green: 0.3943434954, blue: 0.5591766238, alpha: 1), { button in
            self.stackView_subviews.append(button)
        })
                
        extensionButton(callBtn, "phone.fill", #colorLiteral(red: 0.003634299617, green: 0.8856687546, blue: 0, alpha: 1), #colorLiteral(red: 0.03477782011, green: 0.5613020062, blue: 0.06744243205, alpha: 1), {
            button in
            self.stackView_subviews.append(button)
        })
    }
    
    fileprivate func youBeenHereRecentlyLabels(label: String) {
        let header = UILabel()
        header.text = "Вы были здесь недавно"
        header.font = UIFont(name: "Avenir Next Bold", size: 20.0)
        header.allowsDefaultTighteningForTruncation = true
        header.sizeToFit()
        header.frame = header.frame.offsetBy(dx: 5, dy: 5)
        self.addSubview(header)
        
        let body = UILabel()
        body.text = "\(label)"
        body.font = UIFont(name: "Avenir Next Bold", size: 30.0)
        body.allowsDefaultTighteningForTruncation = true
        body.sizeToFit()
        body.frame = body.frame.offsetBy(
            dx: header.frame.minX,
            dy: header.frame.maxY)
        self.addSubview(body)
    }

    fileprivate func setupView(completion: () throws -> Void) {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.center.x = UIScreen.main.bounds.midX
        self.backgroundColor = #colorLiteral(red: 0.5268502831, green: 0.474650979, blue: 0.5886558294, alpha: 1)
        do {
            try completion()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override init(frame: CGRect) {
        
//        let hv = HeaderView.shared.frame.height
//
//        let defaultFrame: CGRect = CGRect(
//            x: 0,
//            y: hv + (hv * 0.1),
//            width: UIScreen.main.bounds.width * 0.95,
//            height: UIScreen.main.bounds.height / 4.5)
        super.init(frame: frame)
        
        setupView(completion: {
            youBeenHereRecentlyLabels(label: "Label Label")
            buttonsPanel()
            
            stackView = UIStackView(arrangedSubviews: stackView_subviews)
            stackView.frame = CGRect(
                x: self.bounds.midX,
                y: self.bounds.minY,
                width: stackView.arrangedSubviews.first?.frame.width ?? self.frame.height / 4,
                height: self.frame.height)
            stackView.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.alignment = .fill
            stackView.spacing = 10
//            stackView.translatesAutoresizingMaskIntoConstraints = false

            
//            stackView.center.y = self.bounds.midY
            addSubview(stackView)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
}
