//
//  RecipeDetailFeatureDIContainer.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

import DIContainer
import UIKit
import Dependencies
import Base

public class RecipeDetailFeatureDIContainer: RecipeDetailFeatureDependencies {
    
    private let diContainer: DIContainer

    public init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    @MainActor public func makeRecipeDetailViewController(with viewData: BaseViewData) -> UIViewController? {
        guard let viewData = viewData as? RecipeDetailViewData else {
            return nil
        }
        
        guard let viewModel = makeRecipeDetailViewModel(with: viewData) as? RecipeDetailViewModel else {
            return nil
        }
        
        let viewController = RecipeDetailViewController.instantiateFromStoryboard(storyboardName: "RecipeDetailViewController")
        viewController.configure(with: viewModel)
        return viewController
    }
    
    public func makeRecipeDetailViewModel(with viewData: BaseViewData) -> BaseViewModel? {
        guard let viewData = viewData as? RecipeDetailViewData else {
            return nil
        }
        
        return RecipeDetailViewModel(viewData: viewData)
    }
}
