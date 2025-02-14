//
//  RecipeResponse.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

public struct RecipesResponse: Decodable {
    
    public let recipes: [RecipeResponse]
 
    public struct RecipeResponse: Decodable {
        public let id: Int?
        public let name: String?
        public let description: String?
        public let ingredients: [String]?
        public let image: String?
        public let location: LocationResponse?
        public let preparationTime: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, description, ingredients, image, location
            case preparationTime = "prep_time"
        }
        
        public init(id: Int?, name: String?, description: String?, ingredients: [String]?, image: String?, location: LocationResponse?, preparationTime: String?) {
            self.id = id
            self.name = name
            self.description = description
            self.ingredients = ingredients
            self.image = image
            self.location = location
            self.preparationTime = preparationTime
        }
        
        public struct LocationResponse: Decodable {
            public let latitude: Double?
            public let longitude: Double?
            
            enum CodingKeys: String, CodingKey {
                case latitude, longitude
            }
            
            public init(latitude: Double?, longitude: Double?) {
                self.latitude = latitude
                self.longitude = longitude
            }
        }
    }
    
    public init(recipes: [RecipeResponse]) {
        self.recipes = recipes
    }
}
