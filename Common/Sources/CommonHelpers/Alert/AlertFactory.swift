//
//  AlertFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit

public protocol AlertFactory {
    func createAlert(title: String, message: String) -> UIAlertController
}
