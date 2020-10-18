import UIKit

extension RecentPlaces {
    func defaultFont(_ scaleX: CGFloat = 1.0) -> UIFont {
        let defaultSize = (UIScreen.main.bounds.height/UIScreen.main.bounds.width) * 10.0
        guard let customFont = UIFont(
                name: "Avenir Next Bold",
                size: defaultSize * scaleX
        ) else { fatalError() }
        return customFont
    }

}
