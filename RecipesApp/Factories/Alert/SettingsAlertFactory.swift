//
//  SettingsAlertFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit

class SettingsAlertFactory: AlertFactory {
    
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        })
        return alert
    }
}
