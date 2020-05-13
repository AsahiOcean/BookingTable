import UIKit

class PlacePreviewVC: UIViewController {
    @IBOutlet weak var StackFloor: UIStackView!
    @IBOutlet weak var TablesContainer: UIView!
    @IBOutlet weak var FirstFloor: UIView!
    @IBOutlet weak var SecondFloor: UIView!
    @IBAction func FirstFloorTouch(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.StackFloor.alpha = 0
            self.TablesContainer.alpha = 1
        }
    }
    
    @IBAction func SecondFloorTouch(_ sender: UIButton) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TablesContainer.alpha = 0
    }
}
