//
//  RecipeDetailViewModel.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import CommonHelpers
import Base
import Models

class RecipeDetailViewModel: BaseViewModel {
    
    private let viewData: RecipeDetailViewData
    
    private(set) var recipeDetail: Bindable<Recipe?> = Bindable(nil)
    
    init(viewData: RecipeDetailViewData) {
        self.viewData = viewData
        recipeDetail.value = viewData.recipe
    }
}
