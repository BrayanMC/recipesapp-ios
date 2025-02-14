//
//  MapViewControllerTests.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import XCTest
import Models
@testable import Features
import MapKit

@MainActor
final class MapViewControllerTests: XCTestCase {
    
    private var sut: MapViewController!
    private var mapViewModel: MapViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    @MainActor
    func testMapViewController_whenViewDidLoad_mapViewIsAdded() throws {
        // Given
        setupData()
        
        let mapView = sut.mapView
        
        // Then
        XCTAssertTrue(sut.view.subviews.contains(mapView), "The mapView should be added to the view hierarchy")
        
        clearAllObjects()
    }
    
    @MainActor
    func testMapViewController_whenRecipeIsSet_markerIsAdded() throws {
        // Given
        setupData()
        
        let mapView = sut.mapView
        
        // Then
        let annotations = mapView.annotations
        XCTAssertEqual(annotations.count, 1, "There should be one annotation on the map")
        
        let annotation = try XCTUnwrap(annotations.first, "The annotation should not be nil")
        XCTAssertEqual(
            annotation.coordinate.latitude,
            mapViewModel.viewData.recipe.location?.latitude, 
            "The annotation latitude should match the recipe location latitude"
        )
        XCTAssertEqual(
            annotation.coordinate.longitude,
            mapViewModel.viewData.recipe.location?.longitude,
            "The annotation longitude should match the recipe location longitude"
        )
        
        clearAllObjects()
    }
    
    private func setupData() {
        let recipe = Recipe(
            id: 1,
            name: "Ceviche",
            description: "Pescado fresco marinado en jugo de limón con cebollas, cilantro y ajíes",
            ingredients: ["Pescado", "Jugo de limón", "Cebolla", "Cilantro", "Ajíes"],
            image: "https://cdn0.recetasgratis.net/es/posts/7/4/1/ceviche_peruano_18147_orig.jpg",
            location: Recipe.Location(
                latitude: -12.116948802044167,
                longitude: -76.97099887395366
            ),
            preparationTime: "15 mins"
        )
        
        mapViewModel = MapViewModel(viewData: MapViewData(recipe: recipe))
        sut = makeSUT(viewModel: mapViewModel)
        sut.loadViewIfNeeded()
    }
    
    private func clearAllObjects() {
        mapViewModel = nil
        sut = nil
    }
    
    @MainActor
    private func makeSUT(viewModel: MapViewModel) -> MapViewController {
        let viewController = MapViewController.instantiateFromStoryboard(storyboardName: "MapViewController", bundle: .module)
        viewController.configure(with: viewModel)
        return viewController
    }
}
