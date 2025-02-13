//
//  ViewModelFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import CommonManagers
import DI

class ViewModelFactory {
    
    static func makeHomeViewModel(diContainer: DIContainer) -> HomeViewModel {
        let fetchRecipesUseCase = diContainer.resolve(type: FetchRecipesUseCase.self)!
        return HomeViewModel(fetchRecipesUseCase: fetchRecipesUseCase)
    }

    static func makeRecipeDetailViewModel(with viewData: RecipeDetailViewData, diContainer: DIContainer) -> RecipeDetailViewModel {
        return RecipeDetailViewModel(viewData: viewData)
    }

    static func makeMapViewModel(with viewData: MapViewData, diContainer: DIContainer) -> MapViewModel {
        return MapViewModel(viewData: viewData)
    }
}
