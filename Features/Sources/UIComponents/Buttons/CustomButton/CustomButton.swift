//
//  CustomButton.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit

public class CustomButton: UIButton {
    
    private var _code: Int = CustomButtonCodes.primary.rawValue
    
    public enum ImagePosition {
        case left
        case right
    }
    
    @IBInspectable var code: Int {
        get {
            return _code
        }
        set {
            _code = newValue
            updateStyles()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customBuilder()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customBuilder()
    }

    private func customBuilder() {
        updateStyles()
    }
    
    private func updateStyles() {
        switch _code {
        case CustomButtonCodes.primary.rawValue:
            setPrimaryButton()
        case CustomButtonCodes.secondary.rawValue:
            setSecondaryButton()
        default:
            break
        }
    }

    private func setPrimaryButton() {
        AppThemeManager.shared.applyPrimaryButtonStyle(to: self)
    }

    private func setSecondaryButton() {
        // empty
    }
    
    public func enable() {
        isEnabled = true
        isUserInteractionEnabled = true
        alpha = 1
    }

    public func disable() {
        isEnabled = false
        isUserInteractionEnabled = false
        alpha = 0.5
    }
}
