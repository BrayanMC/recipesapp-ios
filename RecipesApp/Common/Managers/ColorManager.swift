//
//  ColorManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public final class ColorManager {
    
    public static let shared = ColorManager()

    private init() {}

    private func color(named name: String) -> UIColor {
        return UIColor(named: name) ?? .black
    }
    
    public var black: UIColor {
        return color(named: "Black")
    }
    
    public var gray4: UIColor {
        return color(named: "Gray4")
    }
    
    public var gray3: UIColor {
        return color(named: "Gray3")
    }
    
    public var gray2: UIColor {
        return color(named: "Gray2")
    }
    
    public var gray1: UIColor {
        return color(named: "Gray1")
    }
    
    public var secondary: UIColor {
        return color(named: "Secondary")
    }
    
    public var white: UIColor {
        return color(named: "White")
    }
}
