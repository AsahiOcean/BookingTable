import UIKit

let TabBarCollectionViewCellID = "TabBarCollectionViewCell"

class TabBarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tabNameLabel: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
                
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
