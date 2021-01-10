import UIKit

extension RecentPlaces {
    func defaultFont(_ scaleX: CGFloat = 1.0) -> UIFont {
        guard let customFont = UIFont(
            name: "Avenir Next Bold",
            size: bounds.height/10 * scaleX
        ) else { fatalError() }
        return customFont
    }
}
