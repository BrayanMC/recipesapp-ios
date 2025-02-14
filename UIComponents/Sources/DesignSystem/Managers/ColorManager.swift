//
//  ColorManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public final class ColorManager {

    private static func color(named name: String) -> UIColor {
        return UIColor(named: name, in: .module, compatibleWith: nil) ?? .black
    }
    
    public static var black: UIColor {
        return color(named: "Black")
    }
    
    public static var gray4: UIColor {
        return color(named: "Gray4")
    }
    
    public static var gray3: UIColor {
        return color(named: "Gray3")
    }
    
    public static var gray2: UIColor {
        return color(named: "Gray2")
    }
    
    public static var gray1: UIColor {
        return color(named: "Gray1")
    }
    
    public static var secondary: UIColor {
        return color(named: "Secondary")
    }
    
    public static var white: UIColor {
        return color(named: "White")
    }
}
