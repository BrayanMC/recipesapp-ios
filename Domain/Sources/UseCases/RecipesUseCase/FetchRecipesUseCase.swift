//
//  FetchRecipesUseCase.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import Models

public class FetchRecipesUseCase: FetchRecipesUseCaseProtocol {
    
    private let recipesRepository: RecipesRepositoryProtocol
    
    public init(recipesRepository: RecipesRepositoryProtocol) {
        self.recipesRepository = recipesRepository
    }
    
    public func execute() -> Single<[Recipe]> {
        recipesRepository.fetchRecipes()
    }
}
