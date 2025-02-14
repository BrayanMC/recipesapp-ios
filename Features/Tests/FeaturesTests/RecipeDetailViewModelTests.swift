//
//  RecipeDetailViewModelTests.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import XCTest
import Models
import UseCases
import Networking
import DataMocks
import RxSwift
@testable import Features

final class RecipeDetailViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testRecipeDetailViewModel_WhenInitializedWithRecipe_RecipeShouldBeSet() {
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
        let viewData = RecipeDetailViewData(recipe: recipe)
        
        // When
        let sut = makeSUT(viewData: viewData)
        
        // Then
        XCTAssertEqual(sut.recipeDetail.value?.id, 1)
        XCTAssertEqual(sut.recipeDetail.value?.name, "Ceviche")
        XCTAssertEqual(sut.recipeDetail.value?.description, "Pescado fresco marinado en jugo de limón con cebollas, cilantro y ajíes")
        XCTAssertEqual(sut.recipeDetail.value?.ingredients, ["Pescado", "Jugo de limón", "Cebolla", "Cilantro", "Ajíes"])
        XCTAssertEqual(sut.recipeDetail.value?.image, "https://cdn0.recetasgratis.net/es/posts/7/4/1/ceviche_peruano_18147_orig.jpg")
        XCTAssertEqual(sut.recipeDetail.value?.location?.latitude, -12.116948802044167)
        XCTAssertEqual(sut.recipeDetail.value?.location?.longitude, -76.97099887395366)
        XCTAssertEqual(sut.recipeDetail.value?.preparationTime, "15 mins")
    }
    
    private func makeSUT(viewData: RecipeDetailViewData) -> RecipeDetailViewModel {
        RecipeDetailViewModel(viewData: viewData)
    }
}
