//
//  RecipeDetailViewData.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import Base
import Models

public struct RecipeDetailViewData: BaseViewData {
    public let recipe: Recipe
    
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}
