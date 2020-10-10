import UIKit

class ViewController: UIViewController {
    
    fileprivate var loader: Loader!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loader = Loader()
    }
}
