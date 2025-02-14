//
//  Recipe.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import Networking

struct Recipe: Decodable {
    let id: Int
    let name: String
    let description: String
    let ingredients: [String]
    let image: String
    let location: Location?
    let preparationTime: String
    
    struct Location: Decodable {
        let latitude: Double
        let longitude: Double
    }
}

extension Recipe {
    
    init(from response: RecipesResponse.RecipeResponse) {
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
