//
//  UIImageExtension.swift
//  Utils
//
//  Created by iMac on 4/27/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

extension UIImage {
    func scaleImage(size: CGSize) -> UIImage? {
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        let cgImage: CGImage = self.cgImage!.cropping(to: rect)!
        return UIImage(cgImage: cgImage,
                       scale: self.size.width/size.width,
                       orientation: self.imageOrientation)
//        return UIImage(cgImage: cgImage, scale: image.size.width / size.width, orientation: image.imageOrientation)
    }
    
    func scaleImageToWidth(_ scale: CGFloat) -> UIImage? {
        let scaleValue = scale/self.size.width
        let newSize = CGSize(width: scaleValue*self.size.width, height: scaleValue*self.size.height)
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
//            let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
//            let cgImage: CGImage = self.cgImage!.cropping(to: rect)!
//            return UIImage(cgImage: cgImage,
//                           scale: self.size.width/scale,
//                           orientation: self.imageOrientation)
    }
    
    func normalizedImage() -> UIImage {
        if (self.imageOrientation == UIImage.Orientation.up) {
            return self;
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)

        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
    
    func resized() -> UIImage {
        var actualHeight = Float(size.height)
        var actualWidth = Float(size.width)
        let maxHeight: Float = 480.0
        let maxWidth: Float = 640.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 1.0
        //50 percent compression
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img?.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!) ?? UIImage()
    }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
           
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}
