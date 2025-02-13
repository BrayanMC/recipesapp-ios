//
//  ReusableView.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}
