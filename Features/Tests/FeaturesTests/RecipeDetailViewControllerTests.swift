//
//  RecipeDetailViewControllerTests.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import XCTest
import Models
@testable import Features

@MainActor
final class RecipeDetailViewControllerTests: XCTestCase {
    
    private var sut: RecipeDetailViewController!
    private var recipeDetailViewModel: RecipeDetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    func testRecipeDetailViewController_whenViewDidLoad_labelsAreSetCorrectly() throws {
        // Given
        setupData()
        
        let recipe = recipeDetailViewModel.recipeDetail.value
        
        // When
        let nameLabel = try XCTUnwrap(sut.foodPlateNameLabel, "The foodPlateNameLabel is not connected to an IBOutlet")
        let descriptionLabel = try XCTUnwrap(sut.descriptionLabel, "The descriptionLabel is not connected to an IBOutlet")
        let preparationTimeLabel = try XCTUnwrap(sut.preparationTimeLabel, "The preparationTimeLabel is not connected to an IBOutlet")
        
        // Then
        XCTAssertEqual(nameLabel.text, recipe?.name, "The name label should display the recipe name")
        XCTAssertEqual(descriptionLabel.text, recipe?.description, "The description label should display the recipe description")
        XCTAssertEqual(preparationTimeLabel.text, recipe?.preparationTime, "The preparation time label should display the recipe preparation time")
        
        clearAllObjects()
    }
    
    func testRecipeDetailViewController_whenViewDidLoad_imageIsSetCorrectly() throws {
        // Given
        setupData()
        
        // When
        let imageView = try XCTUnwrap(sut.foodPlateImageView, "The foodPlateImageView is not connected to an IBOutlet")
        let expectation = self.expectation(description: "Image should be set")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Then
            XCTAssertNotNil(imageView.image, "The imageView should have an image set")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
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
        
        recipeDetailViewModel = RecipeDetailViewModel(viewData: RecipeDetailViewData(recipe: recipe))
        sut = makeSUT(viewModel: recipeDetailViewModel)
        sut.loadViewIfNeeded()
    }
    
    private func clearAllObjects() {
        recipeDetailViewModel = nil
        sut = nil
    }
    
    @MainActor
    private func makeSUT(viewModel: RecipeDetailViewModel) -> RecipeDetailViewController {
        let viewController = RecipeDetailViewController.instantiateFromStoryboard(storyboardName: "RecipeDetailViewController", bundle: .module)
        viewController.configure(with: viewModel)
        return viewController
    }
}
