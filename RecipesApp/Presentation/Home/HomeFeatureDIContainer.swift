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
import Repositories
import Networking
import UseCases

public class HomeFeatureDIContainer: HomeFeatureDependencies {
    
    private let diContainer: DIContainer

    public init(diContainer: DIContainer) {
        self.diContainer = diContainer
        
        let networkManager = NetworkManager()
        diContainer.register(type: NetworkManager.self, service: networkManager)
        
        let remoteRecipesRepository = RemoteRecipesRepository(networkManager: networkManager)
        diContainer.register(type: RemoteRecipesRepository.self, service: remoteRecipesRepository)
        
        let fetchRecipesUseCase = FetchRecipesUseCase(recipesRepository: remoteRecipesRepository)
        diContainer.register(type: FetchRecipesUseCase.self, service: fetchRecipesUseCase)
    }

    @MainActor public func makeHomeViewController() -> UIViewController? {
        guard let viewModel = makeHomeViewModel() as? HomeViewModel else {
            return nil
        }
        
        let viewController = HomeViewController.instantiateFromStoryboard(storyboardName: "HomeViewController")
        viewController.configure(with: viewModel)
        return viewController
    }
    
    public func makeHomeViewModel() -> BaseViewModel? {
        let fetchRecipesUseCase = diContainer.resolve(type: FetchRecipesUseCase.self)!
        return HomeViewModel(fetchRecipesUseCase: fetchRecipesUseCase)
    }
}
