import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.load()
        
        let header = HeaderView(frame: CGRect(x: 0, y: 0,
                                width: view.frame.width,
                                height: view.frame.height * 0.10))
        self.view.addSubview(header)
//        let recentPlaces = RecentPlaces()
//        self.view.addSubview(recentPlaces)
        OperationQueue.current?.addOperation({

        })
    }
}
