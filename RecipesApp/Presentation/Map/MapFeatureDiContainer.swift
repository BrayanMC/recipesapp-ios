//
//  MapFeatureDIContainer.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 13/02/25.
//

import DIContainer
import UIKit
import Dependencies
import Base

public class MapFeatureDIContainer: MapFeatureDependencies {
    
    private let diContainer: DIContainer

    public init(diContainer: DIContainer) {
        self.diContainer = diContainer
    }

    @MainActor public func makeMapViewController(with viewData: BaseViewData) -> UIViewController? {
        guard let viewData = viewData as? MapViewData else {
            return nil
        }
        
        guard let viewModel = makeMapViewModel(with: viewData) as? MapViewModel else {
            return nil
        }
        
        let viewController = MapViewController.instantiateFromStoryboard(storyboardName: "MapViewController")
        viewController.configure(with: viewModel)
        return viewController
    }
    
    public func makeMapViewModel(with viewData: BaseViewData) -> BaseViewModel? {
        guard let viewData = viewData as? MapViewData else {
            return nil
        }
        
        return MapViewModel(viewData: viewData)
    }
}
