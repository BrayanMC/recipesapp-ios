//
//  HomeFeatureDIContainer.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

import DIContainer
import UIKit
import Dependencies
import Base

public class HomeFeatureDIContainer: HomeFeatureDependencies {
    
    private let diContainer: DIContainer

    public init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    @MainActor public func makeHomeViewController() -> UIViewController? {
        guard let viewModel = makeHomeViewModel() as? HomeViewModel else {
            return nil
        }
        
        let alertFactory = diContainer.resolve(type: AlertFactory.self)!
        let viewController = HomeViewController.instantiateFromStoryboard(storyboardName: "HomeViewController")
        viewController.configure(with: viewModel, alertFactory: alertFactory)
        return viewController
    }
    
    public func makeHomeViewModel() -> BaseViewModel? {
        let fetchRecipesUseCase = diContainer.resolve(type: FetchRecipesUseCase.self)!
        return HomeViewModel(fetchRecipesUseCase: fetchRecipesUseCase)
    }
}
