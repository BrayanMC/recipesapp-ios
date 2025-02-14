//
//  MapViewData.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import Base
import Models

public struct MapViewData: BaseViewData {
    public let recipe: Recipe
    
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}
