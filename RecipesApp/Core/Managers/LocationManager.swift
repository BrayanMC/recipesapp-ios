//
//  LocationManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?
    var onLocationUpdate: ((CLLocation) -> Void)?
    var onLocationServicesDisabled: (() -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
    }

    /// Checks if location services are enabled and requests authorization if needed.
    func checkLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async { [weak self] in
                    self?.locationManager.requestWhenInUseAuthorization()
                }
            } else {
                // Notify that location services are disabled
                DispatchQueue.main.async { [weak self] in
                    self?.onLocationServicesDisabled?()
                }
            }
        }
    }

    /// Starts updating the location.
    func startUpdatingLocation() {
        DispatchQueue.global().async { [weak self] in
            self?.locationManager.startUpdatingLocation()
        }
    }

    /// Stops updating the location.
    func stopUpdatingLocation() {
        DispatchQueue.global().async { [weak self] in
            self?.locationManager.stopUpdatingLocation()
        }
    }

    /// Called when the authorization status changes.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async { [weak self] in
            self?.onAuthorizationChange?(manager.authorizationStatus)
        }
    }

    /// Called when the location is updated.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async { [weak self] in
            self?.onLocationUpdate?(location)
        }
    }
}
