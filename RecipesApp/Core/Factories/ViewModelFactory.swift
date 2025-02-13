//
//  ViewModelFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

class ViewModelFactory {
    
    static func makeHomeViewModel() -> HomeViewModel {
        let networkManager = NetworkManager()
        let recipesRepository = RemoteRecipesRepository(networkManager: networkManager)
        let fetchRecipesUseCase = FetchRecipesUseCase(recipesRepository: recipesRepository)
        
        return HomeViewModel(
            fetchRecipesUseCase: fetchRecipesUseCase
        )
    }
    
    static func makeRecipeDetailViewModel(with viewData: RecipeDetailViewData) -> RecipeDetailViewModel {
        RecipeDetailViewModel(
            viewData: viewData
        )
    }
    
    static func makeMapViewModel(with viewData: MapViewData) -> MapViewModel {
        MapViewModel(
            viewData: viewData
        )
    }
}
