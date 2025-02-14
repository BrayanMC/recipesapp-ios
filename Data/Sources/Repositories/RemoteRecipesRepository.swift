//
//  RemoteRecipesRepository.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import Networking

public class RemoteRecipesRepository: RecipesRepositoryProtocol {
    
    private let networkManager: NetworkManager
    
    public init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    public func fetchRecipes() -> Single<RecipesResponse> {
        let endpoint = Endpoint.Recipes.all()
        return networkManager.request(endpoint.urlString)
    }
    
    public func fetchRecipeDetail(request: FetchRecipeRequest) -> Single<RecipesResponse.RecipeResponse> {
        let endpoint = Endpoint.Recipes.recipeDetailWithId(request.recipeId)
        return networkManager.request(endpoint.urlString)
    }
}
