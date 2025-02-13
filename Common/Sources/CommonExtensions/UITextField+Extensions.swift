//
//  UITextField+Extensions.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

extension UITextField {
    
    public func setPadding(left: CGFloat? = nil, right: CGFloat? = nil) {
        if let leftPadding = left {
            setLeftPadding(leftPadding)
        }
        
        if let rightPadding = right {
            setRightPadding(rightPadding)
        }
    }

    private func setLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }

    private func setRightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.size.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    public func setLeftViewWithPadding(_ view: UIView, padding: CGFloat) {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width + padding, height: frame.size.height))
        view.frame = CGRect(x: padding / 2, y: (outerView.frame.size.height - view.frame.size.height) / 2, width: view.frame.size.width, height: view.frame.size.height)
        outerView.addSubview(view)
        leftView = outerView
        leftViewMode = .always
    }
}
