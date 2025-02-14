//
//  MapViewModelTests.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import XCTest
import Models
import UseCases
import Networking
import DataMocks
@testable import Features

final class MapViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testMapViewModel_WhenInitializedWithRecipe_RecipeShouldBeSet() {
        // Given
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
        let viewData = MapViewData(recipe: recipe)
        
        // When
        let sut = makeSUT(viewData: viewData)
        
        // Then
        XCTAssertEqual(sut.recipe.value?.id, 1)
        XCTAssertEqual(sut.recipe.value?.name, "Ceviche")
        XCTAssertEqual(sut.recipe.value?.description, "Pescado fresco marinado en jugo de limón con cebollas, cilantro y ajíes")
        XCTAssertEqual(sut.recipe.value?.ingredients, ["Pescado", "Jugo de limón", "Cebolla", "Cilantro", "Ajíes"])
        XCTAssertEqual(sut.recipe.value?.image, "https://cdn0.recetasgratis.net/es/posts/7/4/1/ceviche_peruano_18147_orig.jpg")
        XCTAssertEqual(sut.recipe.value?.location?.latitude, -12.116948802044167)
        XCTAssertEqual(sut.recipe.value?.location?.longitude, -76.97099887395366)
        XCTAssertEqual(sut.recipe.value?.preparationTime, "15 mins")
    }
    
    private func makeSUT(viewData: MapViewData) -> MapViewModel {
        MapViewModel(viewData: viewData)
    }
}
