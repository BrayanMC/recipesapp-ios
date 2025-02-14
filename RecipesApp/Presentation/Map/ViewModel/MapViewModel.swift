//
//  MapViewModel.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import CoreLocation
import CommonHelpers
import Base
import CommonManagers
import Models

class MapViewModel: BaseViewModel {
    
    var recipe: Bindable<Recipe?> = Bindable(nil)
    var authorizationStatus: Bindable<CLAuthorizationStatus?> = Bindable(nil)
    var locationUpdate: Bindable<CLLocation?> = Bindable(nil)
    var locationServicesDisabled: Bindable<Bool> = Bindable(false)
    
    private let viewData: MapViewData
    private let locationManager = LocationManager()
    
    init(viewData: MapViewData) {
        self.viewData = viewData
        super.init()
        setupLocationManager()
        recipe.value = viewData.recipe
    }
    
    private func setupLocationManager() {
        locationManager.onAuthorizationChange = { [weak self] status in
            self?.authorizationStatus.value = status
        }
        locationManager.onLocationUpdate = { [weak self] location in
            self?.locationUpdate.value = location
        }
        locationManager.onLocationServicesDisabled = { [weak self] in
            self?.locationServicesDisabled.value = true
        }
        locationManager.checkLocationServices()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func checkLocationServices() {
        locationManager.checkLocationServices()
    }
}
