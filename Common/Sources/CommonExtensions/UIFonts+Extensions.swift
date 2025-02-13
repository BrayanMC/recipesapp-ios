//
//  UIFonts+Extensions.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit
import CommonHelpers

extension UIFont {
    
    public static func museoSansFont(type: MuseoSansFont, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont()
    }
}
