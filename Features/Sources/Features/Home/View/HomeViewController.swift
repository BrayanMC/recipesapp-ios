//
//  HomeViewController.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 10/02/25.
//

import UIKit
import CommonHelpers
import Base
import Factories
import Models
import DesignSystem
import Helpers

public class HomeViewController: BaseViewController, Storyboarded {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchCustomTextField: CustomTextField!
    @IBOutlet weak var recipesTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let cellHeight: CGFloat = 112.0
    private let rowSpacing: CGFloat = 8.0
    
    private var viewModel: HomeViewModel?
    var appCoordinator: AppCoordinator?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.fetchRecipes()
        }
        hideKeyboardWhenTappedAround()
    }
    
    func configure(with viewModel: HomeViewModel) {
        self.viewModel = viewModel
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
        recipesTableView.register(RecipeCellView.self, bundle: .module)
        recipesTableView.alwaysBounceVertical = true
        recipesTableView.separatorStyle = .none
        recipesTableView.reloadData()
    }
    
    private func prepareNavigationBar() {
        configureNavigationBar(isHidden: true)
    }
    
    public func fetchRecipes() {
        viewModel?.fetchRecipes()
    }
    
    private func showErrorAlert(with messageError: String) {
        refreshControl.endRefreshing()
        appCoordinator?.showAlert(title: "Ocurrió un error", message: messageError)
    }
    
    public func navigateToDetail(with recipe: Recipe) {
        appCoordinator?.navigateToDetail(with: recipe)
    }
    
    @objc private func refreshRecipesData(_ sender: Any) {
        searchCustomTextField.setTextValue(text: "")
        viewModel?.clear()
        fetchRecipes()
    }
}

extension HomeViewController: ViewStylerProtocol {
    
    public func configureViewStyles() {
        //AppThemeManager.shared.applyTextLargeStyle(to: titleLabel)
    }
}

extension HomeViewController: CustomTextFieldEventsProtocol {
    
    public func editingDidBegin(forField id: Int, _ text: String) {
        // empty
    }
    
    public func editingDidEnd(forField id: Int, _ text: String) {
        // empty
    }
    
    public func editingChanged(forField id: Int, _ text: String) {
        viewModel?.filterText(text)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight - 100 {
            viewModel?.loadNextPage()
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // empty
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        rowSpacing
    }
}

extension HomeViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let recipes = viewModel?.recipes.value, !recipes.isEmpty else { return 5 }
        
        return !searchCustomTextField.getTextValue().isEmpty ? viewModel?.filteredArray.value.count ?? 0 : recipes.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
