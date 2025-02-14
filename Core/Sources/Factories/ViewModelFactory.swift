//
//  ViewModelFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit
import Dependencies
import Base

public class ViewModelFactory {
    
    private let homeDependencies: HomeFeatureDependencies
    private let recipeDetailDependencies: RecipeDetailFeatureDependencies
    private let mapDependencies: MapFeatureDependencies

    public init(homeDependencies: HomeFeatureDependencies, recipeDetailDependencies: RecipeDetailFeatureDependencies, mapDependencies: MapFeatureDependencies) {
        self.homeDependencies = homeDependencies
        self.recipeDetailDependencies = recipeDetailDependencies
        self.mapDependencies = mapDependencies
    }
    
    @MainActor public func makeHomeViewModel() -> BaseViewModel? {
        homeDependencies.makeHomeViewModel()
    }

    @MainActor public func makeRecipeDetailViewModel(with viewData: BaseViewData) -> BaseViewModel? {
        recipeDetailDependencies.makeRecipeDetailViewModel(with: viewData)
    }

    @MainActor public func makeMapViewModel(with viewData: BaseViewData) -> BaseViewModel? {
        mapDependencies.makeMapViewModel(with: viewData)
    }
}
