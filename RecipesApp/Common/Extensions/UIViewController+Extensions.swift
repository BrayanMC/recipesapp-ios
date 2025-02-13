//
//  UIViewController+Extensions.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

extension UIViewController {
    
    public func configureNavigationBar(isHidden: Bool = false, title: String = "") {
        guard let navigationController = navigationController else { return }
        
        navigationController.setNavigationBarHidden(isHidden, animated: false)
        
        if !title.isEmpty {
            navigationItem.title = title
        }
        
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorManager.shared.black,
            NSAttributedString.Key.font: UIFont.museoSansFont(type: .W500, size: 20)
        ]
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.tintColor = ColorManager.shared.black
        
        navigationItem.hidesBackButton = true
    }
    
    func presentInNavigationController(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .overCurrentContext
        present(navigationController, animated: animated, completion: completion)
    }
}
