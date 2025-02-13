//
//  AppThemeManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public final class AppThemeManager {
    
    public static let shared: AppThemeManager = AppThemeManager()
    private var theme: ThemeProtocol?

    private init() {}

    public func setAppTheme(theme: ThemeProtocol) {
        self.theme = theme
    }

    public func getTheme() -> ThemeProtocol {
        guard let appTheme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to access AppThemeManager.getTheme()")
        }
        return appTheme
    }

    public func resetTheme() {
        theme = nil
    }
    
    public func applyTextLargeStyle(to label: UILabel, color: UIColor = ColorManager.shared.black) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyTextLargeStyle(to: label, color: color)
    }
    
    public func applyTextMediumStyle(to label: UILabel, color: UIColor = ColorManager.shared.black) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyTextMediumStyle(to: label, color: color)
    }
    
    public func applyTextSmallStyle(to label: UILabel, color: UIColor = ColorManager.shared.black) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyTextSmallStyle(to: label, color: color)
    }
    
    public func applyH2Style(to label: UILabel, color: UIColor = ColorManager.shared.black) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyH2Style(to: label, color: color)
    }
    
    public func applyH3Style(to label: UILabel, color: UIColor = ColorManager.shared.black) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyH3Style(to: label, color: color)
    }
    
    public func applyP2Style(to label: UILabel, color: UIColor = ColorManager.shared.black) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyP2Style(to: label, color: color)
    }
    
    public func applyP3Style(to label: UILabel, color: UIColor = ColorManager.shared.black) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyP3Style(to: label, color: color)
    }
    
    public func applyPrimaryButtonStyle(to button: UIButton, color: UIColor = ColorManager.shared.white) {
        guard let theme = theme else {
            fatalError("Error - Theme must be setup using setAppTheme(_) before trying to apply styles")
        }
        theme.applyPrimaryButtonStyle(to: button, color: color)
    }
}
