//
//  MockRemoteRecipesRepository.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import RxSwift
import Repositories
import Networking
import Foundation

public class MockRemoteRecipesRepository: RecipesRepositoryProtocol {
    
    public var fetchRecipesResult: Single<RecipesResponse>?
    public var fetchRecipeDetailResult: Single<RecipesResponse.RecipeResponse>?
    
    public init() {
        // empty
    }
    
    public func fetchRecipes() -> Single<RecipesResponse> {
        return fetchRecipesResult ?? Single.error(
            NSError(
                domain: "MockRemoteRecipesRepository",
                code: -1,
                userInfo: nil
            )
        )
    }
    
    public func fetchRecipeDetail(request: FetchRecipeRequest) -> Single<RecipesResponse.RecipeResponse> {
        return fetchRecipeDetailResult ?? Single.error(
            NSError(
                domain: "MockRemoteRecipesRepository",
                code: -1,
                userInfo: nil
            )
        )
    }
}
