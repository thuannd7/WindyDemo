//
//  TAppFont.swift
//  Utils
//
//  Created by Macintosh on 10/21/20.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit

class TAppFont: NSObject {
    private static let mapFont: [UIFont.Weight: String] = [
        .ultraLight : "Poppins-Light",
        .thin : "Poppins-Thin",
        .light: "Poppins-Light",
        .regular : "Poppins-Regular",
        .bold: "Poppins-Bold",
        .heavy: "Poppins-ExtraBold",
        .black: "Poppins-Black",
        .medium : "Poppins-Medium",
        .semibold: "Poppins-SemiBold"]
    
    static func font(weight _weight: UIFont.Weight, size _size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: _size, weight: _weight)
    }
}

extension UIFont {
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else { return .regular }
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }

    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any]
            ?? [:]
    }
}

/*
 Poppins - [
 "Poppins-BlackItalic",
 "Poppins-ExtraLight",
 "Poppins-ExtraLightItalic",
 "Poppins-ExtraBold",
 "Poppins-Bold",
 "Poppins-Light",
 "Poppins-ExtraBoldItalic",
 "Poppins-Italic",
 "Poppins-ThinItalic",
 "Poppins-LightItalic",
 "Poppins-Black",
 "Poppins-Medium",
 "Poppins-BoldItalic",
 "Poppins-SemiBold",
 "Poppins-Regular",
 "Poppins-Thin",
 "Poppins-SemiBoldItalic",
 "Poppins-MediumItalic"]
 */
/*
 @available(iOS 8.2, *)


 @available(iOS 8.2, *)


 @available(iOS 8.2, *)

 @available(iOS 8.2, *)


 @available(iOS 8.2, *)

 @available(iOS 8.2, *)


 @available(iOS 8.2, *)


 @available(iOS 8.2, *)

 */
