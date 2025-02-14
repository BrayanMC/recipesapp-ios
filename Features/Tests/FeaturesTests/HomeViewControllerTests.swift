//
//  HomeViewControllerTests.swift
//  Features
//
//  Created by Brayan Munoz Campos on 14/02/25.
//

import XCTest
import Models
import DomainMocks
@testable import Features

@MainActor
final class HomeViewControllerTests: XCTestCase, Sendable {
    
    private var sut: HomeViewController!
    private var mockFetchRecipesUseCase: MockFetchRecipesUseCase!
    private var homeViewModel: HomeViewModel!
    private var spyNavigationController: SpyNavigationController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    @MainActor
    func testHomeViewController_whenViewDidLoad_SearchCustomTextFieldIsDisabled() throws {
        // Given
        setupData()
        
        let searchCustomTextField = try XCTUnwrap(sut.searchCustomTextField, "The searchCustomTextField is not connected to an IBOutlet")
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertFalse(searchCustomTextField.isEnabled, "The custom textfield should be disabled")
        
        clearAllObjects()
    }
    
    func testHomeViewController_whenRecipesLoaded_SearchCustomTextFieldIsEnabled() throws {
        // Given
        setupData()
        
        let searchCustomTextField = try XCTUnwrap(sut.searchCustomTextField, "The searchCustomTextField is not connected to an IBOutlet")
        XCTAssertFalse(searchCustomTextField.isEnabled, "The custom textfield should be initially disabled")
        
        // When
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
                preparationTime: "15 mins")
        ]
        mockFetchRecipesUseCase.fetchRecipesResult = .just(recipes)
        let expectation = self.expectation(description: "Recipes fetched")
        sut.fetchRecipes()
        
        // Then
        XCTAssertTrue(searchCustomTextField.isEnabled, "The custom textfield should be enabled after recipes are loaded")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 1)
        
        clearAllObjects()
    }
    
    func testHomeViewController_whenRecipesLoaded_TableViewHasTenRecords() throws {
        // Given
        setupData()
        
        let recipes = (1...10).map { i in
            Recipe(
                id: i,
                name: "Recipe \(i)",
                description: "Description \(i)",
                ingredients: ["Ingredient \(i)"],
                image: "https://example.com/image\(i).jpg",
                location: Recipe.Location(
                    latitude: Double(i),
                    longitude: Double(i)
                ),
                preparationTime: "\(i) mins"
            )
        }
        mockFetchRecipesUseCase.fetchRecipesResult = .just(recipes)
        let expectation = self.expectation(description: "Recipes fetched")
        sut.fetchRecipes()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.recipesTableView.numberOfSections, 10, "The table view should have 10 sections")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
        
        clearAllObjects()
    }
    
    /*
     func testHomeViewController_whenCellTapped_navigatesToRecipeDetailViewController() throws {
         // Given
         setupData()
         
         let _ = try XCTUnwrap(sut.recipesTableView, "The recipesTableView is not connected to an IBOutlet")
         
         let recipes = (1...10).map { i in
             Recipe(
                 id: i,
                 name: "Recipe \(i)",
                 description: "Description \(i)",
                 ingredients: ["Ingredient \(i)"],
                 image: "https://example.com/image\(i).jpg",
                 location: Recipe.Location(
                     latitude: Double(i),
                     longitude: Double(i)
                 ),
                 preparationTime: "\(i) mins"
             )
         }
         mockFetchRecipesUseCase.fetchRecipesResult = .just(recipes)
         sut.fetchRecipes()
         
         // When
         let indexPath = IndexPath(row: 0, section: 0)
         let expectation = self.expectation(description: "Navigation to RecipeDetailViewController")
         
         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
             self.sut.navigateToDetail(with: recipes[0])
             expectation.fulfill()
         }
         
         // Then
         wait(for: [expectation], timeout: 2)
         let pushedViewController = spyNavigationController.pushedViewController
         XCTAssertTrue(pushedViewController is RecipeDetailViewController, "The pushed view controller should be RecipeDetailViewController")
         
         clearAllObjects()
     }
     */
        
    private func setupData() {
        mockFetchRecipesUseCase = MockFetchRecipesUseCase()
        homeViewModel = HomeViewModel(fetchRecipesUseCase: mockFetchRecipesUseCase)
        sut = makeSUT(viewModel: homeViewModel)
        spyNavigationController = SpyNavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
    }
    
    private func clearAllObjects() {
        mockFetchRecipesUseCase = nil
        homeViewModel = nil
        sut = nil
        spyNavigationController = nil
    }
    
    @MainActor
    private func makeSUT(viewModel: HomeViewModel) -> HomeViewController {
        let viewController = HomeViewController.instantiateFromStoryboard(storyboardName: "HomeViewController", bundle: .module)
        viewController.configure(with: viewModel)
        return viewController
    }
}
