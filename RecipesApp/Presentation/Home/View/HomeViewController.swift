//
//  HomeViewController.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 10/02/25.
//

import UIKit

class HomeViewController: BaseViewController, Storyboarded {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchCustomTextField: CustomTextField!
    @IBOutlet weak var recipesTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let cellHeight: CGFloat = 112.0
    private let rowSpacing: CGFloat = 8.0
    
    private var viewModel: HomeViewModel?
    private var alertFactory: AlertFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.fetchRecipes()
        }
        hideKeyboardWhenTappedAround()
    }
    
    func configure(with viewModel: HomeViewModel, alertFactory: AlertFactory) {
        self.viewModel = viewModel
        self.alertFactory = alertFactory
    }
    
    private func setupView() {
        configureViewStyles()
        prepareNavigationBar()
        searchCustomTextField.displayView(
            eventsDelegate: self,
            placeholder: "customTextField_placeholder_searchRecipe".localized,
            textFieldType: .Search(),
            isEnabled: false
        )
        prepareTableView()
    }
    
    private func setupBindings() {
        viewModel?.recipes.bind { [weak self] result in
            guard let self = self else { return }
            if !result.isEmpty {
                searchCustomTextField.isEnabled = true
                recipesTableView.reloadData()
                refreshControl.endRefreshing()
            }
        }
        
        viewModel?.filteredArray.bind { [weak self] _ in
            guard let self = self else { return }
            self.recipesTableView.reloadData()
        }
        
        viewModel?.error.bind { [weak self] error in
            guard let self = self, let error = error else { return }
            showErrorAlert(with: error)
        }
    }
    
    private func prepareTableView() {
        recipesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshRecipesData(_:)), for: .valueChanged)
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.register(RecipeCellView.self)
        recipesTableView.alwaysBounceVertical = true
        recipesTableView.separatorStyle = .none
        recipesTableView.reloadData()
    }
    
    private func prepareNavigationBar() {
        configureNavigationBar(isHidden: true)
    }
    
    private func fetchRecipes() {
        viewModel?.fetchRecipes()
    }
    
    private func showErrorAlert(with messageError: String) {
        refreshControl.endRefreshing()
        if let alert = alertFactory?.createAlert(title: "Ocurrió un error", message: messageError) {
            present(alert, animated: true, completion: nil)
        } else {
            print("No se pudo crear la alerta de servicios de ubicación desactivados.")
        }
    }
    
    public func navigateToDetail(with recipe: Recipe) {
        let viewData = RecipeDetailViewData(recipe: recipe)
        let viewController = ViewControllerFactory.makeRecipeDetailViewController(with: viewData)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func refreshRecipesData(_ sender: Any) {
        searchCustomTextField.setTextValue(text: "")
        viewModel?.clear()
        fetchRecipes()
    }
}

extension HomeViewController: ViewStylerProtocol {
    
    func configureViewStyles() {
        AppThemeManager.shared.applyTextLargeStyle(to: titleLabel)
    }
}

extension HomeViewController: CustomTextFieldEventsProtocol {
    
    func editingDidBegin(forField id: Int, _ text: String) {
        // empty
    }
    
    func editingDidEnd(forField id: Int, _ text: String) {
        // empty
    }
    
    func editingChanged(forField id: Int, _ text: String) {
        viewModel?.filterText(text)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 100 {
            viewModel?.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // empty
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        rowSpacing
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let recipes = viewModel?.recipes.value, !recipes.isEmpty else { return 5 }
        
        return !searchCustomTextField.getTextValue().isEmpty ? viewModel?.filteredArray.value.count ?? 0 : recipes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecipeCellView = tableView.dequeueCell(forIndexPath: indexPath)
        
        if let recipes = viewModel?.recipes.value, !recipes.isEmpty {
            var recipe: Recipe
            
            if let filteredRecipes = viewModel?.filteredArray.value, !filteredRecipes.isEmpty {
                recipe = filteredRecipes[indexPath.section]
            } else {
                recipe = recipes[indexPath.section]
            }
            cell.buildCell(with: recipe)
            cell.recipeAction = { [weak self] recipe in
                guard let self = self else { return }
                navigateToDetail(with: recipe)
            }
        } else {
            cell.displayShimmers()
        }
        
        return cell
    }
}
