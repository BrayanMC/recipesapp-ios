//
//  DefaultAlertFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit

public class DefaultAlertFactory: @preconcurrency AlertFactory {
    
    public init() {
        // empty
    }
    
    @MainActor public func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
