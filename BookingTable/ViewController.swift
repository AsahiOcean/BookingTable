import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.load()
        
        let header = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.10))
        self.view.addSubview(header)
        
        let recentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY, width: self.view.frame.width * 0.95, height: view.frame.height * 0.25))
        self.view.addSubview(recentPlaces)
    }
}
