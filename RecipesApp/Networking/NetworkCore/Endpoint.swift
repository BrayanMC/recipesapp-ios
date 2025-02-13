//
//  Endpoint.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import Foundation

struct Endpoint {
    
    let path: String
    let queryItems: [URLQueryItem]?
    
    var urlString: String {
        var components = URLComponents(string: "http://demo4358631.mockable.io" + path)!
        components.queryItems = queryItems
        return components.url!.absoluteString
    }
    
    var url: URL {
        return URL(string: urlString)!
    }
    
    // MARK: Products
    struct Recipes {
        static func all() -> Endpoint {
            return Endpoint(path: "/recipes", queryItems: nil)
        }
        
        static func byPagination(offset: Int, limit: Int) -> Endpoint {
            return Endpoint(path: "/recipes", queryItems: [
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ])
        }
        
        static func recipeDetailWithId(_ recipeId: String) -> Endpoint {
            return Endpoint(path: "/recipes/\(recipeId)", queryItems: nil)
        }
    }
}
