//
//  DefaultTheme.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public class DefaultTheme: ThemeProtocol {
    
    public init() {}

    public func applyTextLargeStyle(to label: UILabel, color: UIColor) {
        label.font = .museoSansFont(type: .W700, size: 24)
        label.setLineHeight(lineHeight: 6)
        label.textColor = color
    }

    public func applyTextMediumStyle(to label: UILabel, color: UIColor) {
        label.font = .museoSansFont(type: .W500, size: 20)
        label.setLineHeight(lineHeight: 6)
        label.textColor = color
    }
    
    public func applyTextSmallStyle(to label: UILabel, color: UIColor) {
        label.font = .museoSansFont(type: .W300, size: 12)
        label.setLineHeight(lineHeight: 6)
        label.textColor = color
    }
    
    public func applyH2Style(to label: UILabel, color: UIColor) {
        label.font = .museoSansFont(type: .W700, size: 20)
        label.setLineHeight(lineHeight: 10)
        label.textColor = color
    }
    
    public func applyH3Style(to label: UILabel, color: UIColor) {
        label.font = .museoSansFont(type: .W700, size: 18)
        label.setLineHeight(lineHeight: 10)
        label.textColor = color
    }
    
    public func applyP2Style(to label: UILabel, color: UIColor) {
        label.font = .museoSansFont(type: .W300, size: 16)
        label.setLineHeight(lineHeight: 10)
        label.textColor = color
    }
    
    public func applyP3Style(to label: UILabel, color: UIColor) {
        label.font = .museoSansFont(type: .W300, size: 14)
        label.setLineHeight(lineHeight: 6)
        label.textColor = color
    }
    
    public func applyPrimaryButtonStyle(to button: UIButton, color: UIColor) {
        button.layer.cornerRadius = 4
        button.backgroundColor = ColorManager.shared.secondary
        button.setTitleColor(ColorManager.shared.white, for: .normal)
        button.titleLabel?.font = .museoSansFont(type: .W500, size: 16)
        button.isUserInteractionEnabled = true
        button.isEnabled = true
    }
}
