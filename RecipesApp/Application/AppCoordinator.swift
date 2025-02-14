//
//  AppCoordinator.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

import UIKit
import DIContainer
import Factories
import Dependencies
import CommonHelpers
import Models

@MainActor
class AppCoordinator {
    
    private let navigationController: UINavigationController
    private let diContainer: DIContainer
    let viewControllerFactory: ViewControllerFactory
    let alertFactory: AlertFactory
    let settingsAlertFactory: AlertFactory

    init(
        navigationController: UINavigationController,
        diContainer: DIContainer,
        alertFactory: AlertFactory,
        settingsAlertFactory: AlertFactory
    ) {
        self.navigationController = navigationController
        self.diContainer = diContainer
        self.alertFactory = alertFactory
        self.settingsAlertFactory = settingsAlertFactory
        
        let homeDiContainer: HomeFeatureDependencies = HomeFeatureDIContainer(diContainer: diContainer)
        let recipeDetailDiContainer: RecipeDetailFeatureDependencies = RecipeDetailFeatureDIContainer(diContainer: diContainer)
        let mapDiContainer: MapFeatureDependencies = MapFeatureDIContainer(diContainer: diContainer)
        
        viewControllerFactory = ViewControllerFactory(
            homeDependencies: homeDiContainer,
            recipeDetailDependencies: recipeDetailDiContainer,
            mapDependencies: mapDiContainer
        )
    }

    func start() {
        guard let viewController = viewControllerFactory.makeHomeViewController() as? HomeViewController else {
            debugPrint("Error: Expected HomeViewController but got a different type.")
            return
        }
        
        viewController.appCoordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToDetail(with recipe: Recipe) {
        let viewData = RecipeDetailViewData(recipe: recipe)
        guard let viewController = viewControllerFactory.makeRecipeDetailViewController(with: viewData) as? RecipeDetailViewController else {
            debugPrint("Error: Expected RecipeDetailViewController but got a different type.")
            return
        }
        
        viewController.appCoordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToMap(with recipe: Recipe) {
        let viewData = MapViewData(recipe: recipe)
        guard let viewController = viewControllerFactory.makeMapViewController(with: viewData) as? MapViewController else {
            debugPrint("Error: Expected MapViewController but got a different type.")
            return
        }
        
        viewController.appCoordinator = self
        navigationController.viewControllers.last?.presentInNavigationController(viewController: viewController)
    }
    
    func showAlert(title: String, message: String) {
        let alert = alertFactory.createAlert(title: title, message: message)
        navigationController.present(alert, animated: true, completion: nil)
    }
    
    func showSettingsAlert(title: String, message: String) {
        let alert = settingsAlertFactory.createAlert(title: title, message: message)
        navigationController.present(alert, animated: true, completion: nil)
    }
}
