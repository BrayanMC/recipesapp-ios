//
//  RecipesRepositoryProtocol.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift

protocol RecipesRepositoryProtocol {
    func fetchRecipes() -> Single<RecipesResponse>
    func fetchRecipeDetail(request: FetchRecipeRequest) -> Single<RecipesResponse.RecipeResponse>
}
