import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.load()
        OperationQueue.current?.addOperation({
            let testFrame = CGRect(x: 0, y: 0, width: 0, height: 100)
            let myView = HeaderView()
            self.view.addSubview(myView)
        })
    }
}
