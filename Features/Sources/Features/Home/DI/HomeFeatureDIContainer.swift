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
import Helpers

public class HomeFeatureDIContainer: HomeFeatureDependencies {
    
    private let diContainer: DIContainer

    public init(diContainer: DIContainer) {
        self.diContainer = diContainer
        
        let networkManager = diContainer.resolve(type: NetworkManager.self) ?? NetworkManager()
        let remoteRecipesRepository: RecipesRepositoryProtocol = RemoteRecipesRepository(networkManager: networkManager)
        diContainer.register(type: RemoteRecipesRepository.self, service: remoteRecipesRepository as! RemoteRecipesRepository)
        
        let fetchRecipesUseCase = FetchRecipesUseCase(recipesRepository: remoteRecipesRepository)
        diContainer.register(type: FetchRecipesUseCase.self, service: fetchRecipesUseCase)
    }

    @MainActor public func makeHomeViewController() -> UIViewController? {
        guard let viewModel = makeHomeViewModel() as? HomeViewModel else {
            return nil
        }
        
        let viewController = HomeViewController.instantiateFromStoryboard(
            storyboardName: "HomeViewController",
            bundle: .module
        )
        viewController.configure(with: viewModel)
        return viewController
    }
    
    public func makeHomeViewModel() -> BaseViewModel? {
        let fetchRecipesUseCase = diContainer.resolve(type: FetchRecipesUseCase.self)!
        return HomeViewModel(fetchRecipesUseCase: fetchRecipesUseCase)
    }
}
