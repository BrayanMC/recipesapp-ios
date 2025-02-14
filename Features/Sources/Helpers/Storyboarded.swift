//
//  Storyboarded.swift
//  
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

/// Protocol to be adopted by `UIViewController` instances that are instantiated from a storyboard.
public protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    
    /// Instantiates a `UIViewController` from a Xib file.
    ///
    /// - Parameter bundle: The bundle containing the Xib file and its resources. If `nil`, the main bundle is used.
    /// - Returns: An instance of the view controller.
    @MainActor public static func instantiateFromXib(bundle: Bundle? = nil) -> Self {
        let identifier = String(describing: self)
        let bundleToUse = bundle ?? Bundle.main
        return Self(nibName: identifier, bundle: bundleToUse)
    }
    
    /// Instantiates a `UIViewController` from a storyboard.
    ///
    /// - Parameters:
    ///   - storyboardName: The name of the storyboard.
    ///   - bundle: The bundle containing the storyboard file and its resources. If `nil`, the main bundle is used.
    /// - Returns: An instance of the view controller.
    @MainActor public static func instantiateFromStoryboard(storyboardName: String, bundle: Bundle? = nil) -> Self {
        let identifier = String(describing: self)
        let bundleToUse = bundle ?? Bundle.main
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundleToUse)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
}
