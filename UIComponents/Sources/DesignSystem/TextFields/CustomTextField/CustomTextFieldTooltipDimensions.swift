//
//  CustomTextFieldTooltipDimensions.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public enum CustomTextFieldTooltipDimensions {
    case small
    case medium
    case large

    var size: (width: CGFloat, height: CGFloat) {
        switch self {
        case .small:
            return (width: 18, height: 18)
        case .medium:
            return (width: 150, height: 75)
        case .large:
            return (width: 200, height: 100)
        }
    }
}
