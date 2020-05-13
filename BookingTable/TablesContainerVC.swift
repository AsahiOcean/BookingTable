import UIKit

class TablesContainerVC: UIViewController {
    @IBOutlet weak var Table: UIView!
    
    @IBAction func TableSelected(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) {
            self.Table.backgroundColor = .systemGreen
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
