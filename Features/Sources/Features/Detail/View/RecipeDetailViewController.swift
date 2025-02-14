//
//  RecipeDetailViewController.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit
import CommonHelpers
import CommonManagers
import CommonExtensions
import Base
import Models
import UIComponents
import Helpers

public class RecipeDetailViewController: BaseViewController, Storyboarded, BackButtonConfigurable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var foodPlateImageView: UIImageView!
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var foodPlateNameLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsTitleLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var ingredientsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var seeUbicationCustomButton: CustomButton!
    
    private let cellHeight: CGFloat = 25.0
    private let rowSpacing: CGFloat = 16.0
    
    private var viewModel: RecipeDetailViewModel?
    var appCoordinator: AppCoordinator?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateIngredientsTableViewHeight()
        ingredientsTableView.isHidden = false
        seeUbicationCustomButton.isHidden = false
    }
    
    func configure(with viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupView() {
        configureViewStyles()
        prepareNavigationBar()
        addBackButton(action: #selector(backButtonTapped), to: containerView)
        detailContainerView.roundCorners(named: [.topLeft, .topRight], with: 16)
        
        let shadowColor = UIColor.black
        let shadowOffset = CGSize(width: 1, height: 1)
        let shadowRadius: CGFloat = 4
        let shadowOpacity: Float = 0.1
        
        detailContainerView.addTopShadow(
            shadowColor: shadowColor,
            offset: shadowOffset,
            shadowRadius: shadowRadius,
            shadowOpacity: shadowOpacity
        )
        
        prepareTableView()
    }
    
    private func prepareNavigationBar() {
        configureNavigationBar(isHidden: true)
    }
    
    private func setupBindings() {
        viewModel?.recipeDetail.bind { [weak self] result in
            guard let self = self, let result = result else { return }
            displayDetail(with: result)
        }
    }
    
    private func prepareTableView() {
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.register(IngredientCellView.self, bundle: .module)
        ingredientsTableView.separatorStyle = .none
    }
    
    private func updateIngredientsTableViewHeight() {
        guard let ingredients = viewModel?.recipeDetail.value?.ingredients else { return }
        
        let ingredientsQuantity = ingredients.count
        ingredientsHeightConstraint.constant = (cellHeight + rowSpacing) * CGFloat(ingredientsQuantity)
    }
    
    private func displayDetail(with recipe: Recipe) {
        foodPlateImageView.contentMode = .scaleToFill
        foodPlateImageView.loadImageFromURL(with: recipe.image)
        foodPlateNameLabel.text = recipe.name
        preparationTimeLabel.text = recipe.preparationTime
        descriptionLabel.text = recipe.description
        ingredientsTableView.reloadData()
    }
    
    @objc func backButtonTapped() {
        backTo()
    }
    
    @IBAction func goToLocationCustomButtonTapped(_ sender: Any) {
        guard let recipe = viewModel?.recipeDetail.value else { return }
        appCoordinator?.navigateToMap(with: recipe)
    }
}

extension RecipeDetailViewController: ViewStylerProtocol {
    
    public func configureViewStyles() {
        AppThemeManager.shared.applyH2Style(to: foodPlateNameLabel)
        AppThemeManager.shared.applyP2Style(to: preparationTimeLabel, color: ColorManager.gray2)
        AppThemeManager.shared.applyH3Style(to: descriptionTitleLabel, color: ColorManager.gray1)
        AppThemeManager.shared.applyP2Style(to: descriptionLabel, color: ColorManager.gray2)
        AppThemeManager.shared.applyH3Style(to: ingredientsTitleLabel, color: ColorManager.gray1)
    }
}

extension RecipeDetailViewController: UITableViewDelegate {
    
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

extension RecipeDetailViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.recipeDetail.value?.ingredients.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: IngredientCellView = tableView.dequeueCell(forIndexPath: indexPath)
        
        if let ingredients = viewModel?.recipeDetail.value?.ingredients {
            let ingredient: String = ingredients[indexPath.section]
            cell.buildCell(with: ingredient)
        }
        
        return cell
    }
}
