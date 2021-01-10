import UIKit

class TabTableViewCell: UITableViewCell {
    static public var id: String { String(describing: self )}
    static public var nib: UINib { UINib(nibName: id, bundle: nil )}
    @IBOutlet weak var cellLabel: UILabel!
}
