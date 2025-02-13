//
//  ViewControllerFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import DI
import UIKit
import CommonManagers
import CommonHelpers

class ViewControllerFactory {
    
    @MainActor static func makeHomeViewController(diContainer: DIContainer) -> HomeViewController {
        let viewModel = ViewModelFactory.makeHomeViewModel(diContainer: diContainer)
        let alertFactory = diContainer.resolve(type: AlertFactory.self)!
        let viewController = HomeViewController.instantiateFromStoryboard(storyboardName: "HomeViewController")
        viewController.configure(with: viewModel, alertFactory: alertFactory)
        return viewController
    }

    @MainActor static func makeRecipeDetailViewController(with viewData: RecipeDetailViewData, diContainer: DIContainer) -> RecipeDetailViewController {
        let viewModel = ViewModelFactory.makeRecipeDetailViewModel(with: viewData, diContainer: diContainer)
        let viewController = RecipeDetailViewController.instantiateFromStoryboard(storyboardName: "RecipeDetailViewController")
        viewController.configure(with: viewModel)
        return viewController
    }

    @MainActor static func makeMapViewController(with viewData: MapViewData, diContainer: DIContainer) -> MapViewController {
        let viewModel = ViewModelFactory.makeMapViewModel(with: viewData, diContainer: diContainer)
        let alertFactory = diContainer.resolve(type: AlertFactory.self)!
        let settingsAlertFactory = diContainer.resolve(type: AlertFactory.self)!
        let viewController = MapViewController.instantiateFromStoryboard(storyboardName: "MapViewController")
        viewController.configure(with: viewModel, alertFactory: alertFactory, settingsAlertFactory: settingsAlertFactory)
        return viewController
    }
}
