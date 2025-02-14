//
//  BackButtonConfigurable.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit
import CommonHelpers
import CommonManagers

@MainActor
public protocol BackButtonConfigurable {
    /// Adds the back button to the view and sets up its constraints.
    /// - Parameters:
    ///   - action: The selector to be called when the back button is tapped.
    ///   - contentView: The content view to which the back button should be added. If nil, the button is added to the main view.
    func addBackButton(action: Selector, to contentView: UIView?)
}

extension BackButtonConfigurable where Self: UIViewController {
    
    /// Back button that is added to the view.
    private var backButton: UIButton {
        let button = UIButton(type: .custom)
        button.setImage(ImageManager.shared.image(named: ImageNames.icBackNormal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    public func addBackButton(action: Selector, to contentView: UIView? = nil) {
        let button = backButton
        button.addTarget(self, action: action, for: .touchUpInside)
        
        let parentView: UIView = contentView ?? view
        parentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 20),
            button.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: 44),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
