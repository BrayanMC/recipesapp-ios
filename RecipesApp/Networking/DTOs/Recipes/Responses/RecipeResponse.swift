//
//  RecipeResponse.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

struct RecipesResponse: Decodable {
    
    let recipes: [RecipeResponse]
 
    struct RecipeResponse: Decodable {
        let id: Int?
        let name: String?
        let description: String?
        let ingredients: [String]?
        let image: String?
        let location: LocationResponse?
        let preparationTime: String?
        
        enum CodingKeys: String, CodingKey {
            case id, name, description, ingredients, image, location
            case preparationTime = "prep_time"
        }
        
        struct LocationResponse: Decodable {
            let latitude: Double?
            let longitude: Double?
            
            enum CodingKeys: String, CodingKey {
                case latitude, longitude
            }
        }
    }
}
