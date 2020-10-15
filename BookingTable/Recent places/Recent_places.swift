import UIKit

class RecentPlaces: UIView {
    
    fileprivate func menu() {
        
    }

    fileprivate func setupView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.center.x = UIScreen.main.bounds.midX
        self.backgroundColor = #colorLiteral(red: 0.5268502831, green: 0.474650979, blue: 0.5886558294, alpha: 1)
    }
    
    init(_frame: CGRect? = nil) {
        
        let hv = HeaderView.shared
        
        let defaultFrame: CGRect = CGRect(
            x: 0,
            y: hv.frame.height + 10,
            width: UIScreen.main.bounds.width * 0.95,
            height: UIScreen.main.bounds.height / 4.5)
        super.init(frame: _frame ?? defaultFrame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        if aDecoder == .none {
            fatalError("init(coder:) has not been implemented")
        } else {
            super.init(coder: aDecoder)
        }
    }
}
