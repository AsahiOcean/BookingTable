import UIKit

class InitialTableViewCell: UITableViewCell {
    
    static public var id: String { String(describing: self )}
    static public var nib: UINib { UINib(nibName: id, bundle: nil )}
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
}
