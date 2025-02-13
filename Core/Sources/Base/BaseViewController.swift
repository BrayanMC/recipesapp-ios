//
//  BaseViewController.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit
import CommonExtensions

open class BaseViewController: UIViewController {
    
    public func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.dismissKeyboard()
    }
    
    public func backTo() {
        navigationController?.popViewController(animated: true)
    }
    
    public func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}
