//
//  SpyNavigationController.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
