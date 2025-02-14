//
//  Recipe.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

public typealias Recipes = [Recipe]

public struct Recipe: Decodable {
    public let id: Int
    public let name: String
    public let description: String
    public let ingredients: [String]
    public let image: String
    public let location: Location?
    public let preparationTime: String
    
    public init(id: Int, name: String, description: String, ingredients: [String], image: String, location: Location?, preparationTime: String) {
        self.id = id
        self.name = name
        self.description = description
        self.ingredients = ingredients
        self.image = image
        self.location = location
        self.preparationTime = preparationTime
    }
    
    public struct Location: Decodable {
        public let latitude: Double
        public let longitude: Double
        
        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}
