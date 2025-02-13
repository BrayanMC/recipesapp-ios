//
//  UIImageView+Extensions.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImageFromURL(with url: String) {
        self.sd_setImage(with: URL(string: url))
    }
}
