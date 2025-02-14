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
        
        public struct LocationResponse: Decodable {
            public let latitude: Double?
            public let longitude: Double?
            
            enum CodingKeys: String, CodingKey {
                case latitude, longitude
            }
        }
    }
}
