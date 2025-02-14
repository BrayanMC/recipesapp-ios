//
//  CloseButtonConfigurable.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

@MainActor
public protocol CloseButtonConfigurable {
    /// Adds the close button to the view and sets up its constraints.
    /// - Parameters:
    ///   - action: The selector to be called when the close button is tapped.
    ///   - contentView: The content view to which the close button should be added. If nil, the button is added to the main view.
    func addCloseButton(action: Selector, to contentView: UIView?)
}

extension CloseButtonConfigurable where Self: UIViewController {
    
    /// Close button that is added to the view.
    private var closeButton: UIButton {
        let button = UIButton(type: .custom)
        button.setImage(ImageManager.shared.image(named: ImageNames.icCloseNormal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    public func addCloseButton(action: Selector, to contentView: UIView? = nil) {
        let button = closeButton
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
