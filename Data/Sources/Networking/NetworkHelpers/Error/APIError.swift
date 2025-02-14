//
//  APIError.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

public struct APIError: Error {
    public let message: String
    public let error: String
    public let code: Int
    
    public init(message: String, error: String, code: Int) {
        self.message = message
        self.error = error
        self.code = code
    }
}
