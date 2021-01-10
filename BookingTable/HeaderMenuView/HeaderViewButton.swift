import UIKit

final class HeaderViewButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let image = UIImage(systemName: "line.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withTintColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), renderingMode: .alwaysOriginal).scaleX(2)
        setImage(image, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
