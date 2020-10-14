import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.load()
        OperationQueue.current?.addOperation({
            let headerView = HeaderView()
            self.view.addSubview(headerView)
        })
    }
}
