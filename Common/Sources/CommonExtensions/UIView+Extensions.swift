//
//  UIView+Extensions.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit
import SkeletonView
import CommonHelpers
import CommonManagers

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
              layer.cornerRadius = newValue
              layer.masksToBounds = (newValue > 0)
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    public func addShadow(
        shadowColor: UIColor = ShadowValues.shadowColor,
        offset: CGSize = ShadowValues.shadowOffset,
        shadowRadius: CGFloat = ShadowValues.shadowRadius,
        shadowOpacity: Float = ShadowValues.shadowOpacity
    ) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = offset
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
    
    public func addTopShadow(
        shadowColor: UIColor = ShadowValues.shadowColor,
        offset: CGSize = ShadowValues.shadowOffset,
        shadowRadius: CGFloat = ShadowValues.shadowRadius,
        shadowOpacity: Float = ShadowValues.shadowOpacity
    ) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = offset
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false

        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: 0))
        shadowPath.addLine(to: CGPoint(x: bounds.width, y: 0))
        shadowPath.addLine(to: CGPoint(x: bounds.width, y: shadowRadius))
        shadowPath.addLine(to: CGPoint(x: 0, y: shadowRadius))
        shadowPath.close()

        layer.shadowPath = shadowPath.cgPath
    }
    
    public func addTapGesture(_ target: Any, action: Selector) {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
    
    public func dismissKeyboard() {
        endEditing(true)
    }
    
    public func isShimmer(_ isActive: Bool, cornerRadius: Float = 0) {
        if isActive {
            
            skeletonCornerRadius = cornerRadius
            isSkeletonable = true
            (self as? UILabel)?.linesCornerRadius = Int(cornerRadius)
            let skeletonLayer = SkeletonGradient(baseColor: ColorManager.gray4.withAlphaComponent(0.5))
            showAnimatedGradientSkeleton(usingGradient: skeletonLayer)
        } else {
            hideSkeleton()
        }
    }
    
    public func roundCorners(named corners: UIRectCorner, with radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
}
