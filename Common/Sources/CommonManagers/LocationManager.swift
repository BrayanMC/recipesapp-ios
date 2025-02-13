//
//  LocationManager.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit
import MapKit
import CoreLocation

public final class LocationManager: NSObject, CLLocationManagerDelegate, @unchecked Sendable {
    
    private let locationManager = CLLocationManager()
    public var onAuthorizationChange: ((CLAuthorizationStatus) -> Void)?
    public var onLocationUpdate: ((CLLocation) -> Void)?
    public var onLocationServicesDisabled: (() -> Void)?

    public override init() {
        super.init()
        locationManager.delegate = self
    }

    /// Checks if location services are enabled and requests authorization if needed.
    public func checkLocationServices() {
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
    public func startUpdatingLocation() {
        DispatchQueue.global().async { [weak self] in
            self?.locationManager.startUpdatingLocation()
        }
    }

    /// Stops updating the location.
    public func stopUpdatingLocation() {
        DispatchQueue.global().async { [weak self] in
            self?.locationManager.stopUpdatingLocation()
        }
    }

    /// Called when the authorization status changes.
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let authorizationStatus = manager.authorizationStatus
        DispatchQueue.main.async { [weak self] in
            self?.onAuthorizationChange?(authorizationStatus)
        }
    }

    /// Called when the location is updated.
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async { [weak self] in
            self?.onLocationUpdate?(location)
        }
    }
}
