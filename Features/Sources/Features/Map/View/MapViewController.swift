//
//  MapViewController.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit
import MapKit
import CoreLocation
import CommonHelpers
import Base
import Models
import DesignSystem
import Helpers

public class MapViewController: BaseViewController, Storyboarded, CloseButtonConfigurable {
    
    private var viewModel: MapViewModel?
    var appCoordinator: AppCoordinator?
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupView()
        setupBindings()
        viewModel?.checkLocationServices()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.stopUpdatingLocation()
    }
    
    func configure(with viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupView() {
        prepareNavigationBar()
        addCloseButton(action: #selector(closeButtonTapped), to: mapView)
        setMapConstraints()
    }
    
    private func prepareNavigationBar() {
        configureNavigationBar(isHidden: true)
    }
    
    private func setupBindings() {
        viewModel?.recipe.bind { [weak self] result in
            guard let self = self, let result = result else { return }
            self.addMarker(for: result)
        }
        
        viewModel?.authorizationStatus.bind { [weak self] status in
            guard let self = self, let status = status else { return }
            self.handleLocationAuthorization(status: status)
        }
        
        viewModel?.locationUpdate.bind { [weak self] location in
            guard let self = self, let location = location else { return }
            self.updateMapRegion(with: location)
        }
        
        viewModel?.locationServicesDisabled.bind { [weak self] isDisabled in
            guard let self = self, isDisabled else { return }
            self.showLocationServicesDisabledAlert()
        }
    }
    
    private func setMapConstraints() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func handleLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            viewModel?.startUpdatingLocation()
        case .denied, .restricted:
            showLocationPermissionAlert()
        case .notDetermined:
            viewModel?.checkLocationServices()
        @unknown default:
            break
        }
    }
    
    private func updateMapRegion(with location: CLLocation) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    private func addMarker(for recipe: Recipe) {
        guard let location = recipe.location else { return }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: location.latitude,
            longitude: location.longitude
        )
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    private func showLocationServicesDisabledAlert() {
        appCoordinator?.showAlert(
            title: "Servicios de Ubicación Desactivados",
            message: "Por favor, habilita los servicios de ubicación en Configuración."
        )
    }

    private func showLocationPermissionAlert() {
        appCoordinator?.showSettingsAlert(
            title: "Permiso de Ubicación Denegado",
            message: "Por favor, habilita los permisos de ubicación en Configuración."
        )
    }
    
    @objc func closeButtonTapped() {
        dismiss()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view.annotation {
            debugPrint("Marker selected at coordinate: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        }
    }
}
