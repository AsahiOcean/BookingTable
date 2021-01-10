import UIKit

extension UIImage {
    public func scaleX(_ scaleX: CGFloat = 1.0) -> UIImage {
        
        let scaledImageSize = CGSize(width: size.width * scaleX, height: size.height * scaleX)
        
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        
        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: CGSize(
                    width: scaledImageSize.width,
                    height: scaledImageSize.height
                )
            ))
        }
        return scaledImage
    }
}
