import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.load()
        
        let header = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.10))
        self.view.addSubview(header)
        
        let recentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30))
        self.view.addSubview(recentPlaces)
    }
}
