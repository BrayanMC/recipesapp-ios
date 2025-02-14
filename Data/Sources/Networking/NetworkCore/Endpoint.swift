//
//  Endpoint.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import Foundation

public struct Endpoint {
    
    let path: String
    let queryItems: [URLQueryItem]?
    
    public var urlString: String {
        var components = URLComponents(string: "http://demo4358631.mockable.io" + path)!
        components.queryItems = queryItems
        return components.url!.absoluteString
    }
    
    public var url: URL {
        return URL(string: urlString)!
    }
    
    // MARK: Recipes
    
    public struct Recipes {
        
        public static func all() -> Endpoint {
            return Endpoint(path: "/recipes", queryItems: nil)
        }
        
        public static func byPagination(offset: Int, limit: Int) -> Endpoint {
            return Endpoint(path: "/recipes", queryItems: [
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ])
        }
        
        public static func recipeDetailWithId(_ recipeId: String) -> Endpoint {
            return Endpoint(path: "/recipes/\(recipeId)", queryItems: nil)
        }
    }
}
