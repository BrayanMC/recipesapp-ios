//
//  RemoteRecipesRepository.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift

class RemoteRecipesRepository: RecipesRepositoryProtocol {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchRecipes() -> Single<RecipesResponse> {
        let endpoint = Endpoint.Recipes.all()
        return networkManager.request(endpoint.urlString)
    }
    
    func fetchRecipeDetail(request: FetchRecipeRequest) -> Single<RecipesResponse.RecipeResponse> {
        let endpoint = Endpoint.Recipes.recipeDetailWithId(request.recipeId)
        return networkManager.request(endpoint.urlString)
    }
}
