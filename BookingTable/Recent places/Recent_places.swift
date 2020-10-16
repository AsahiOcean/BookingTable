import UIKit

class RecentPlaces: UIView {
    
    fileprivate func buttons() {
        
        let padding: CGFloat = 10.0
        
        let btn1 = UIButton()
        btn1.layer.frame = CGRect(
            x: frame.width * 0.80,
            y: frame.height / 10 - padding,
            width: frame.height / 4,
            height: frame.height / 4)
        btn1.layer.cornerRadius = 16
        btn1.layer.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btn1.isUserInteractionEnabled = true
        self.addSubview(btn1)

        let btn2 = UIButton()
        btn2.layer.frame = CGRect(
            x: btn1.frame.minX,
            y: btn1.frame.maxY + bounds.height/40 + padding,
            width: btn1.frame.width,
            height: btn1.frame.height)
        btn2.layer.cornerRadius = 16
        btn2.layer.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        btn2.isUserInteractionEnabled = true
        self.addSubview(btn2)

        let btn3 = UIButton()
        btn3.layer.frame = CGRect(
            x: btn2.frame.minX,
            y: btn2.frame.maxY + bounds.height/40 + padding,
            width: btn2.frame.width,
            height: btn2.frame.height)
        btn3.layer.cornerRadius = 16
        btn3.layer.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        btn3.isUserInteractionEnabled = true
        self.addSubview(btn3)
    }
    
    fileprivate func youBeenHereRecentlyLabels(label: String) {
        let header = UILabel()
        header.text = "Вы были здесь недавно"
        header.font = UIFont(name: "Avenir Next Bold", size: 20.0)
        header.allowsDefaultTighteningForTruncation = true
        header.sizeToFit()
        header.frame = header.frame.offsetBy(dx: 5, dy: 5)
        //header.layer.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        self.addSubview(header)
        
        let body = UILabel()
        body.text = "\(label)"
        body.font = UIFont(name: "Avenir Next Bold", size: 30.0)
        body.allowsDefaultTighteningForTruncation = true
        body.sizeToFit()
        body.frame = body.frame.offsetBy(
            dx: header.frame.minX,
            dy: header.frame.maxY)
        body.layer.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        self.addSubview(body)
    }

    fileprivate func setupView(completion: () throws -> Void) {
        clipsToBounds = true
        layer.cornerRadius = 5
        center.x = UIScreen.main.bounds.midX
        backgroundColor = #colorLiteral(red: 0.5268502831, green: 0.474650979, blue: 0.5886558294, alpha: 1)
        do {
            try completion()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    init(_frame: CGRect? = nil) {
        
        let hv = HeaderView.shared
        
        let defaultFrame: CGRect = CGRect(
            x: 0,
            y: hv.frame.height + 10,
            width: UIScreen.main.bounds.width * 0.95,
            height: UIScreen.main.bounds.height / 4.5)
        super.init(frame: _frame ?? defaultFrame)
        setupView(completion: {
            youBeenHereRecentlyLabels(label: "Label Label")
            buttons()
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
