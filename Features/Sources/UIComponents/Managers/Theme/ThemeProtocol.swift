//
//  ThemeProtocol.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

@MainActor
public protocol ThemeProtocol {
    func applyTextLargeStyle(to label: UILabel, color: UIColor)
    func applyTextMediumStyle(to label: UILabel, color: UIColor)
    func applyTextSmallStyle(to label: UILabel, color: UIColor)
    func applyH2Style(to label: UILabel, color: UIColor)
    func applyH3Style(to label: UILabel, color: UIColor)
    func applyP2Style(to label: UILabel, color: UIColor)
    func applyP3Style(to label: UILabel, color: UIColor)
    func applyPrimaryButtonStyle(to button: UIButton, color: UIColor)
}
