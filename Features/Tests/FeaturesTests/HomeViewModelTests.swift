//
//  HomeViewModelTests.swift
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

final class HomeViewModelTests: XCTestCase {
    
    private var mockRemoteRecipesRepository: MockRemoteRecipesRepository!
    private var fetchRecipesUseCase: FetchRecipesUseCase!
    
    override func setUpWithError() throws {
        mockRemoteRecipesRepository = MockRemoteRecipesRepository()
        fetchRecipesUseCase = FetchRecipesUseCase(recipesRepository: mockRemoteRecipesRepository)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        mockRemoteRecipesRepository = nil
        fetchRecipesUseCase = nil
        try super.tearDownWithError()
    }
    
    func testHomeViewModel_WhenRecipesLoadedSuccessfully_RecipesShouldBeUpdated() {
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
        mockRemoteRecipesRepository.fetchRecipesResult = .just([recipe])
        
        let sut = makeSUT(fetchRecipesUseCase: fetchRecipesUseCase)
        
        // When
        let expectation = self.expectation(description: "Recipes fetched")
        sut.recipes.bind { recipes in
            if !recipes.isEmpty {
                XCTAssertEqual(recipes.count, 1)
                let recipe = recipes.first
                XCTAssertEqual(recipe?.id, 1)
                XCTAssertEqual(recipe?.name, "Ceviche")
                XCTAssertEqual(recipe?.description, "Pescado fresco marinado en jugo de limón con cebollas, cilantro y ajíes")
                XCTAssertEqual(recipe?.ingredients, ["Pescado", "Jugo de limón", "Cebolla", "Cilantro", "Ajíes"])
                XCTAssertEqual(recipe?.image, "https://cdn0.recetasgratis.net/es/posts/7/4/1/ceviche_peruano_18147_orig.jpg")
                XCTAssertEqual(recipe?.location?.latitude, -12.116948802044167)
                XCTAssertEqual(recipe?.location?.longitude, -76.97099887395366)
                XCTAssertEqual(recipe?.preparationTime, "15 mins")
                expectation.fulfill()
            }
        }
        
        sut.fetchRecipes()
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testHomeViewModel_WhenRecipesLoadingFails_ErrorShouldBeHandled() {
        // Given
        let error = APIError(
            message: ErrorMessage.DefaultError.rawValue,
            error: ErrorTitle.DefaultError.rawValue,
            code: ErrorCode.GenericError.rawValue
        )
        mockRemoteRecipesRepository.fetchRecipesResult = .error(error)
        
        let sut = makeSUT(fetchRecipesUseCase: fetchRecipesUseCase)
        
        // When
        let expectation = self.expectation(description: "Error handled")
        sut.error.bind { receivedError in
            if receivedError != nil {
                XCTAssertEqual(receivedError, ErrorMessage.DefaultError.rawValue)
                expectation.fulfill()
            }
        }
        
        sut.fetchRecipes()
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testHomeViewModel_WhenScrolled_RecipesShouldBeUpdated() {
        // Given
        let recipes = (1...30).map { i in
            Recipe(
                id: i,
                name: "Recipe \(i)",
                description: "Description \(i)",
                ingredients: ["Ingredient \(i)"],
                image: "https://example.com/recipe\(i).jpg",
                location: Recipe.Location(
                    latitude: Double(i),
                    longitude: Double(i)
                ),
                preparationTime: "\(i) mins"
            )
        }
        mockRemoteRecipesRepository.fetchRecipesResult = .just(recipes)
        
        let sut = makeSUT(fetchRecipesUseCase: fetchRecipesUseCase)
        
        // When
        let expectation = self.expectation(description: "Recipes fetched and updated on scroll")
        var allFetchedRecipes: [Recipe] = []
        
        sut.recipes.bind { recipes in
            allFetchedRecipes = recipes
            if allFetchedRecipes.count == 30 {
                expectation.fulfill()
            }
        }
        
        sut.fetchRecipes()
        
        // Simulate scrolling to load next pages
        sut.loadNextPage()
        sut.loadNextPage()
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(allFetchedRecipes.count, 30)
        XCTAssertEqual(allFetchedRecipes.first?.name, "Recipe 1")
        XCTAssertEqual(allFetchedRecipes.last?.name, "Recipe 30")
    }
    
    func testHomeViewModel_WhenFilterTextIsApplied_FilteredArrayShouldBeUpdated() {
        // Given
        let recipes = [
            Recipe(
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
            ),
            Recipe(
                id: 2,
                name: "Tacos",
                description: "Tortillas rellenas de carne, queso y vegetales",
                ingredients: ["Tortilla", "Carne", "Queso", "Vegetales"],
                image: "https://example.com/tacos.jpg",
                location: Recipe.Location(
                    latitude: 19.432608,
                    longitude: -99.133209
                ),
                preparationTime: "20 mins"
            )
        ]
        mockRemoteRecipesRepository.fetchRecipesResult = .just(recipes)
        
        let sut = makeSUT(fetchRecipesUseCase: fetchRecipesUseCase)
        
        // When
        let expectation = self.expectation(description: "Recipes fetched and filtered")
        sut.fetchRecipes()
        
        sut.recipes.bind { recipes in
            if !recipes.isEmpty {
                sut.filterText("Ceviche")
                XCTAssertEqual(sut.filteredArray.value.count, 1)
                XCTAssertEqual(sut.filteredArray.value.first?.name, "Ceviche")
                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testHomeViewModel_WhenFilterTextDoesNotMatchAnyRecipe_FilteredArrayShouldBeEmpty() {
        // Given
        let recipes = [
            Recipe(
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
            ),
            Recipe(
                id: 2,
                name: "Tacos",
                description: "Tortillas rellenas de carne, queso y vegetales",
                ingredients: ["Tortilla", "Carne", "Queso", "Vegetales"],
                image: "https://example.com/tacos.jpg",
                location: Recipe.Location(
                    latitude: 19.432608,
                    longitude: -99.133209
                ),
                preparationTime: "20 mins"
            )
        ]
        mockRemoteRecipesRepository.fetchRecipesResult = .just(recipes)
        
        let sut = makeSUT(fetchRecipesUseCase: fetchRecipesUseCase)
        
        // When
        let expectation = self.expectation(description: "Recipes fetched and filtered with no match")
        sut.fetchRecipes()
        
        sut.recipes.bind { recipes in
            if !recipes.isEmpty {
                sut.filterText("Pizza")
                XCTAssertEqual(sut.filteredArray.value.count, 0)
                expectation.fulfill()
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    private func makeSUT(fetchRecipesUseCase: FetchRecipesUseCase) -> HomeViewModel {
        HomeViewModel(fetchRecipesUseCase: fetchRecipesUseCase)
    }
}
