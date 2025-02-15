//
//  MockRemoteRecipesRepository.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import RxSwift
import UseCases
import Models
import Networking
import Foundation

public class MockRemoteRecipesRepository: RecipesRepositoryProtocol {
    
    public var fetchRecipesResult: Single<Recipes>?
    public var fetchRecipeDetailResult: Single<Recipe>?
    
    public init() {
        // empty
    }
    
    public func fetchRecipes() -> Single<Recipes> {
        return fetchRecipesResult ?? Single.error(
            NSError(
                domain: "MockRemoteRecipesRepository",
                code: -1,
                userInfo: nil
            )
        )
    }
    
    public func fetchRecipeDetail(request recipeId: Int) -> Single<Recipe> {
        return fetchRecipeDetailResult ?? Single.error(
            NSError(
                domain: "MockRemoteRecipesRepository",
                code: -1,
                userInfo: nil
            )
        )
    }
}
