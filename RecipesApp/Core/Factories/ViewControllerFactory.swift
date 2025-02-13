//
//  ViewControllerFactory.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit

class ViewControllerFactory {
    
    static func makeHomeViewController() -> HomeViewController {
        let viewModel = ViewModelFactory.makeHomeViewModel()
        let alertFactory = DefaultAlertFactory()
        let viewController = HomeViewController.instantiateFromStoryboard(storyboardName: "HomeViewController")
        viewController.configure(
            with: viewModel,
            alertFactory: alertFactory
        )
        return viewController
    }
    static func makeRecipeDetailViewController(with viewData: RecipeDetailViewData) -> RecipeDetailViewController {
        let viewModel = ViewModelFactory.makeRecipeDetailViewModel(with: viewData)
        let viewController = RecipeDetailViewController.instantiateFromStoryboard(storyboardName: "RecipeDetailViewController")
        viewController.configure(with: viewModel)
        return viewController
    }
    
    static func makeMapViewController(with viewData: MapViewData) -> MapViewController {
        let viewModel = ViewModelFactory.makeMapViewModel(with: viewData)
        let alertFactory = DefaultAlertFactory()
        let settingsAlertFactory = SettingsAlertFactory()
        let viewController = MapViewController.instantiateFromStoryboard(storyboardName: "MapViewController")
        viewController.configure(
            with: viewModel,
            alertFactory: alertFactory,
            settingsAlertFactory: settingsAlertFactory
        )
        return viewController
    }
}
