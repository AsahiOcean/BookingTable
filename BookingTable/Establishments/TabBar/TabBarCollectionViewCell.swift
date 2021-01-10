import UIKit

class TabBarCollectionViewCell: UICollectionViewCell {
    static public var id: String { String(describing: self )}
    static public var nib: UINib { UINib(nibName: id, bundle: nil )}

    @IBOutlet weak var tabNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
