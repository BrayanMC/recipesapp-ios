//
//  ImageManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public final class ImageManager {
    
    public static let shared: ImageManager = ImageManager()
    
    private var imageCache: [String: UIImage] = [:]
    
    private init() { }
    
    public func image(named name: String) -> UIImage? {
        if let cachedImage = imageCache[name] {
            return cachedImage
        }
        
        guard let image = UIImage(named: name) else {
            return nil
        }
        
        imageCache[name] = image
        return image
    }
    
    public func systemImage(named systemName: String) -> UIImage? {
        if let cachedImage = imageCache[systemName] {
            return cachedImage
        }
        
        guard let image = UIImage(systemName: systemName) else {
            return nil
        }
        
        imageCache[systemName] = image
        return image
    }
}
