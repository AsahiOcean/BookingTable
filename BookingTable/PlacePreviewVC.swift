import UIKit

class PlacePreviewVC: UIViewController {
    @IBOutlet weak var StackFloor: UIStackView!
    @IBOutlet weak var TablesContainer: UIView!
    @IBAction func FirstFloorTouch(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.StackFloor.alpha = 0
            self.TablesContainer.alpha = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
