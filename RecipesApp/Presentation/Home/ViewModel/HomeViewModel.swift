//
//  HomeViewModel.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import RxSwift
import CommonHelpers
import Base
import Networking

class HomeViewModel: BaseViewModel {
    
    private let fetchRecipesUseCase: FetchRecipesUseCase
    
    private(set) var allRecipes: [Recipe] = []
    private(set) var recipes: Bindable<[Recipe]> = Bindable([])
    private(set) var filteredArray: Bindable<[Recipe]> = Bindable([])
    
    private var currentPage = 0
    private let pageSize = 10
    private var isLoading = false
    
    init(fetchRecipesUseCase: FetchRecipesUseCase) {
        self.fetchRecipesUseCase = fetchRecipesUseCase
    }
    
    func fetchRecipes() {
        guard !isLoading else { return }
        
        isLoading = true
        loading.value = true
        
        fetchRecipesUseCase.execute()
            .subscribe(onSuccess: { [weak self] result in
                guard let self = self else { return }
                
                self.allRecipes = result
                self.currentPage = 0
                self.loadPage(page: self.currentPage)
                
                self.isLoading = false
                self.loading.value = false
            }, onFailure: { [weak self] error in
                guard let self = self else { return }
                guard let error = error as? APIError else { return }
                
                self.error.value = error.message
                self.isLoading = false
                self.loading.value = false

            })
            .disposed(by: disposeBag)
    }
    
    private func loadPage(page: Int) {
        let startIndex = page * pageSize
        let endIndex = min(startIndex + pageSize, allRecipes.count)
        
        if startIndex < endIndex {
            let pageRecipes = Array(allRecipes[startIndex..<endIndex])
            if page == 0 {
                recipes.value = pageRecipes
            } else {
                recipes.value += pageRecipes
            }
        }
    }
    
    func loadNextPage() {
        currentPage += 1
        loadPage(page: currentPage)
    }
    
    func filterText(_ query: String) {
        filteredArray.value = recipes.value.filter { recipe in
            recipe.name.lowercased().contains(query.lowercased()) ||
            recipe.ingredients.contains { $0.lowercased().contains(query.lowercased()) }
        }
    }
    
    func clear() {
        allRecipes.removeAll()
        recipes.value.removeAll()
        filteredArray.value.removeAll()
        currentPage = 0
    }
}
