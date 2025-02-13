//
//  ErrorResponse.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

public class ErrorResponse: Decodable {
   public var code: Int?
   public var message: String?
   public var title: String?
    
    private enum CodignKeys : String, CodingKey {
        case code
        case message
        case title
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodignKeys.self)
        code = try? container.decode(Int.self, forKey:.code)
        message = try? container.decode(String.self, forKey:.message)
        title = try? container.decode(String.self, forKey:.title)
    }
}
