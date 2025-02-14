//
//  FetchRecipesUseCase.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import Repositories
import Models

public class FetchRecipesUseCase {
    
    private let recipesRepository: RecipesRepositoryProtocol
    
    public init(recipesRepository: RecipesRepositoryProtocol) {
        self.recipesRepository = recipesRepository
    }
    
    public func execute() -> Single<[Recipe]> {
        return recipesRepository.fetchRecipes()
            .map { response in
                response.recipes.map { Recipe(from: $0) }
            }
    }
}
