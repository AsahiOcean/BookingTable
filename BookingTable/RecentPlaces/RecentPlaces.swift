import UIKit

final class RecentPlaces: UIView {
    
    private var cancelBtn: RecentPlacesButton!
    private var infoBtn: RecentPlacesButton!
    private var callBtn: RecentPlacesButton!
                
    fileprivate func youBeenHereRecentlyLabels(label: String) {        
        let header = UILabel()
        header.text = "Вы были здесь недавно"
        header.font = defaultFont()
        header.allowsDefaultTighteningForTruncation = true
        header.sizeToFit()
        header.frame = header.frame.offsetBy(dx: 5, dy: 5)
        self.addSubview(header)
        
        let body = UILabel()
        body.text = "\(label)"
        body.font = defaultFont(1.5)
        body.allowsDefaultTighteningForTruncation = true
        body.sizeToFit()
        body.frame = body.frame.offsetBy(
            dx: header.frame.minX,
            dy: header.frame.maxY)
        self.addSubview(body)
    }

    fileprivate func setupView(completion: () throws -> Void) {
        layoutIfNeeded()
        layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = 5
        center.x = UIScreen.main.bounds.midX
        self.backgroundColor = #colorLiteral(red: 0.5268502831, green: 0.474650979, blue: 0.5886558294, alpha: 1)
        try? completion()
    }
    
    fileprivate func buttonsPanel() {
        
        let omg = (frame.height/frame.width) * (CGFloat.pi*CGFloat.pi)
        let _frame = CGRect(origin: .zero, size: CGSize(width: frame.height/4, height: frame.height/4))
        
        infoBtn = RecentPlacesButton(frame: _frame)
        infoBtn.gradientSetup(colors: [#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)], true)
        infoBtn.setIcon("info.circle", #colorLiteral(red: 0.1161215678, green: 0.2699673772, blue: 0.4141633809, alpha: 1), scaleX: 0.5)
        infoBtn.layer.frame.origin.y = bounds.midY - infoBtn.bounds.height / 2
        infoBtn.layer.frame.origin.x = bounds.maxX - infoBtn.bounds.width * 1.25
        self.addSubview(infoBtn)
        
        cancelBtn = RecentPlacesButton(frame: _frame)
        cancelBtn.gradientSetup(colors: [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)], true)
        cancelBtn.setIcon("multiply", #colorLiteral(red: 0.3238292336, green: 0.05678842217, blue: 0.1807048023, alpha: 1), scaleX: 0.5)
        cancelBtn.layer.frame.origin.y = infoBtn.layer.frame.origin.y - cancelBtn.bounds.height * 1.25
        cancelBtn.layer.frame.origin.x = bounds.maxX - cancelBtn.bounds.width * 1.25
        self.addSubview(cancelBtn)

        callBtn = RecentPlacesButton(frame: _frame)
        callBtn.gradientSetup(colors: [#colorLiteral(red: 0, green: 0.7012106776, blue: 0.1580332518, alpha: 1),#colorLiteral(red: 0.01960287802, green: 0.2767708302, blue: 0.1104094461, alpha: 1)], true)
        callBtn.setIcon("phone.fill", #colorLiteral(red: 0.01972396486, green: 0.2767394185, blue: 0.1153987721, alpha: 1), scaleX: 0.5)
        callBtn.layer.frame.origin.y = infoBtn.layer.frame.origin.y + callBtn.bounds.height * 1.25
        callBtn.layer.frame.origin.x = bounds.maxX - callBtn.bounds.width * 1.25
        self.addSubview(callBtn)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView(completion: {
            youBeenHereRecentlyLabels(label: "Label Label")
            buttonsPanel()
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
