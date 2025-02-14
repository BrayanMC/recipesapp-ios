//
//  RecipesRepositoryProtocol.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import Models

public protocol RecipesRepositoryProtocol {
    func fetchRecipes() -> Single<Recipes>
    func fetchRecipeDetail(request recipeId: Int) -> Single<Recipe>
}
