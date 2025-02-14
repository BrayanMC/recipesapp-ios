//
//  ViewControllerFactory.swift
//  Core
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

import UIKit
import Dependencies
import Base

public class ViewControllerFactory {
    
    private let homeDependencies: HomeFeatureDependencies
    private let recipeDetailDependencies: RecipeDetailFeatureDependencies
    private let mapDependencies: MapFeatureDependencies

    public init(homeDependencies: HomeFeatureDependencies, recipeDetailDependencies: RecipeDetailFeatureDependencies, mapDependencies: MapFeatureDependencies) {
        self.homeDependencies = homeDependencies
        self.recipeDetailDependencies = recipeDetailDependencies
        self.mapDependencies = mapDependencies
    }

    @MainActor public func makeHomeViewController() -> UIViewController? {
        return homeDependencies.makeHomeViewController()
    }

    @MainActor public func makeRecipeDetailViewController(with viewData: BaseViewData) -> UIViewController? {
        return recipeDetailDependencies.makeRecipeDetailViewController(with: viewData)
    }

    @MainActor public func makeMapViewController(with viewData: BaseViewData) -> UIViewController? {
        return mapDependencies.makeMapViewController(with: viewData)
    }
}
