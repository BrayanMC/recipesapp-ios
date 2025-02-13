//
//  APIError.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

struct APIError: Error {
    let message: String
    let error: String
    let code: Int
}
