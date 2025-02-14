//
//  ViewStylerProtocol.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

@MainActor
public protocol ViewStylerProtocol {
    /// Configures the styles of the view.
    /// This method should be overridden in subclasses to provide custom styling.
    func configureViewStyles()
}
