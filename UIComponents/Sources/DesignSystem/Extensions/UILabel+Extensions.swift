//
//  UILabel+Extensions.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

extension UILabel {
    
    public func setLineHeight(lineHeight: CGFloat) {
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            let range = NSString(string: text).range(of: text)
            style.lineSpacing = lineHeight
            attributeString.addAttribute(.paragraphStyle, value: style, range: range)
            attributedText = attributeString
        }
    }
}
