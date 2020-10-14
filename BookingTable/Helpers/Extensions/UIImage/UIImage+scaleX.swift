import UIKit

extension UIImage {
    func scaleX(_ factor: CGFloat) -> UIImage {
        
        let scaledImageSize = CGSize(
            width: size.width * factor,
            height: size.height * factor
        )

        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}
