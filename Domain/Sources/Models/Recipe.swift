//
//  Recipe.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import Networking

public struct Recipe: Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let ingredients: [String]
    public let image: String
    public let location: Location?
    public let preparationTime: String
    
    public struct Location: Decodable {
        public let latitude: Double
        public let longitude: Double
    }
}

extension Recipe {
    
    public init(from response: RecipesResponse.RecipeResponse) {
        self.id = response.id ?? 0
        self.name = response.name ?? ""
        self.description = response.description ?? ""
        self.ingredients = response.ingredients?.map { $0 } ?? []
        self.image = response.image ?? ""
        self.location = Recipe.Location(from: response.location ?? nil)
        self.preparationTime = response.preparationTime ?? ""
    }
}

extension Recipe.Location {
    
    init(from response: RecipesResponse.RecipeResponse.LocationResponse?) {
        self.latitude = response?.latitude ?? 0.0
        self.longitude = response?.longitude ?? 0.0
    }
}
