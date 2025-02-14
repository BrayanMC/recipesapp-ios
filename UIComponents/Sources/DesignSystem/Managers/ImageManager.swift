//
//  ImageManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public final class ImageManager: @unchecked Sendable {
    
    @MainActor public static let shared: ImageManager = ImageManager()
    
    private var imageCache: [String: UIImage] = [:]
    private let cacheQueue = DispatchQueue(label: "com.example.ImageManager.cacheQueue", attributes: .concurrent)
    
    private init() { }
    
    /// Returns an image with the specified name.
    ///
    /// This method first checks if the image is cached. If it is, the cached image is returned.
    /// If the image is not cached, it attempts to load the image from the asset catalog,
    /// caches it, and then returns the loaded image.
    ///
    /// - Parameter name: The name of the image to retrieve.
    /// - Returns: The image with the specified name, or `nil` if the image could not be found.
    public func image(named name: String) -> UIImage? {
        var cachedImage: UIImage?
        
        // Access the cache synchronously to check if the image is already cached.
        cacheQueue.sync {
            cachedImage = imageCache[name]
        }
        
        // If the image is found in the cache, return it.
        if let cachedImage = cachedImage {
            return cachedImage
        }
        
        // If the image is not found in the cache, try to load it from the asset catalog.
        guard let image = UIImage(named: name, in: .module, with: nil) else {
            return nil
        }
        
        // Cache the newly loaded image asynchronously to avoid blocking the main thread.
        cacheQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.imageCache[name] = image
        }
        
        // Return the newly loaded image.
        return image
    }
    
    /// Returns a system image with the specified name.
    ///
    /// This method first checks if the system image is cached. If it is, the cached image is returned.
    /// If the system image is not cached, it attempts to load the image from the system,
    /// caches it, and then returns the loaded image.
    ///
    /// - Parameter systemName: The name of the system image to retrieve.
    /// - Returns: The system image with the specified name, or `nil` if the image could not be found.
    public func systemImage(named systemName: String) -> UIImage? {
        var cachedImage: UIImage?
        
        // Access the cache synchronously to check if the system image is already cached.
        cacheQueue.sync {
            cachedImage = imageCache[systemName]
        }
        
        // If the system image is found in the cache, return it.
        if let cachedImage = cachedImage {
            return cachedImage
        }
        
        // If the system image is not found in the cache, try to load it from the system.
        guard let image = UIImage(systemName: systemName) else {
            return nil
        }
        
        // Cache the newly loaded system image asynchronously to avoid blocking the main thread.
        cacheQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else { return }
            self.imageCache[systemName] = image
        }
        
        // Return the newly loaded system image.
        return image
    }
}
