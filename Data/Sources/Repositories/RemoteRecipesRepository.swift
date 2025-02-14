//
//  RemoteRecipesRepository.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import Networking
import UseCases
import Models

public class RemoteRecipesRepository: RecipesRepositoryProtocol {
    
    private let networkManager: NetworkManager
    
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    public func fetchRecipes() -> Single<Recipes> {
        let endpoint = Endpoint.Recipes.all()
        return networkManager.request(endpoint.urlString)
            .map { (response: RecipesResponse) in
                let recipes = response.recipes.map { Recipe(from: $0) }
                return Recipes(recipes)
            }
    }
    
    public func fetchRecipeDetail(request recipeId: Int) -> Single<Recipe> {
        let endpoint = Endpoint.Recipes.recipeDetailWithId(recipeId)
        return networkManager.request(endpoint.urlString)
            .map { (response: RecipesResponse.RecipeResponse) in
                return Recipe(from: response)
            }
    }
}
