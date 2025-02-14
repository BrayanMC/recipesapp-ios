//
//  FetchRecipesUseCase.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import Repositories

class FetchRecipesUseCase {
    
    private let recipesRepository: RecipesRepositoryProtocol
    
    init(recipesRepository: RecipesRepositoryProtocol) {
        self.recipesRepository = recipesRepository
    }
    
    func execute() -> Single<[Recipe]> {
        return recipesRepository.fetchRecipes()
            .map { response in
                response.recipes.map { Recipe(from: $0) }
            }
    }
}
