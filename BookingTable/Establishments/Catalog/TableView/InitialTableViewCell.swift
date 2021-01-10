import UIKit

class InitialTableViewCell: UITableViewCell {
    
    static var id: String { String(describing: self) }
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
