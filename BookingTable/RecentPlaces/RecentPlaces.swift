import UIKit

class RecentPlaces: UIView {
        
    fileprivate(set) var cancel: RPButton!
    fileprivate(set) var info: RPButton!
    fileprivate(set) var call: RPButton!
    var header: UILabel = UILabel()
    var estLabel: UILabel = UILabel()
    
    func changeEstLabel(_ text: String) {
        print(text)
        estLabel.text = text
    }
         
    //MARK: -- Labels
    private func labelsSetup() {
        header.font = defaultFont()
        header.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        header.allowsDefaultTighteningForTruncation = true
        header.frame = CGRect(x: .zero,
                              y: cancel.frame.minY,
                              width: cancel.frame.minX,
                              height: header.font.pointSize)
                              .insetBy(dx: cancel.frame.minY, dy: 0)
        header.text = "Вы были здесь недавно"
        addSubview(header)
        
        estLabel.font = defaultFont(1.5)
        estLabel.allowsDefaultTighteningForTruncation = true
        estLabel.frame.origin.x = header.frame.minX
        estLabel.frame.origin.y = header.frame.maxY//+ cancel.frame.minY
        estLabel.frame.size = CGSize(width: header.bounds.width,
                                     height: estLabel.font.pointSize)
        addSubview(estLabel)
    }

    //MARK: -- Buttons
    fileprivate func buttonsPanel() {
        cancel = RPButton(frame: CGRect(origin: .zero,
                                        size: CGSize(
                                        width: bounds.size.height/4,
                                        height: bounds.size.height/4)))
        cancel.gradientSetup([#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)], true)
        cancel.setIcon("multiply", #colorLiteral(red: 0.3238292336, green: 0.05678842217, blue: 0.1807048023, alpha: 1))
        cancel.frame.origin.x = frame.maxX - cancel.bounds.width*1.1
        cancel.frame.origin.y += cancel.bounds.height/10
        addSubview(cancel)
        
        info = RPButton(frame: CGRect(origin: .zero,
                                      size: cancel.bounds.size))
        info.gradientSetup([#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)], true)
        info.setIcon("info.circle", #colorLiteral(red: 0.1161215678, green: 0.2699673772, blue: 0.4141633809, alpha: 1))
        info.center.y = center.y
        info.frame.origin.x = cancel.frame.origin.x
        addSubview(info)
        
        call = RPButton(frame: CGRect(origin: .zero,
                                      size: info.bounds.size))
        call.gradientSetup([#colorLiteral(red: 0, green: 0.7012106776, blue: 0.1580332518, alpha: 1),#colorLiteral(red: 0.01960287802, green: 0.2767708302, blue: 0.1104094461, alpha: 1)], true)
        call.setIcon("phone.fill", #colorLiteral(red: 0.01972396486, green: 0.2767394185, blue: 0.1153987721, alpha: 1))
        call.frame.origin.x = info.frame.origin.x
        call.frame.origin.y = frame.maxY - (call.bounds.height + call.bounds.height/10)
        addSubview(call)
    }
    
    //MARK: -- Setup
    fileprivate func setupView() {
        clipsToBounds = true
        layer.cornerRadius = 12
        layer.borderWidth = 2; layer.borderColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
                layer.backgroundColor = #colorLiteral(red: 0.2873916626, green: 0.3154491484, blue: 0.414301753, alpha: 1)
        buttonsPanel() // 1
        labelsSetup() // 2
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
            
    internal required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
}
