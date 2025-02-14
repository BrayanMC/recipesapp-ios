//
//  RecipeCellView.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit
import CommonExtensions
import CommonManagers
import Models

class RecipeCellView: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var foodPlateImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    var selectedRecipe: Recipe?
    var recipeAction: ((Recipe) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupView() {
        configureViewStyles()
    }
    
    private func setupContentView() {
        contentView.addTapGesture(self, action: #selector(recipeButtonTapped(_:)))
        
        let shadowColor = UIColor.black
        let shadowOffset = CGSize(width: 1, height: 1)
        let shadowRadius: CGFloat = 4
        let shadowOpacity: Float = 0.1
        
        containerView.addShadow(
            shadowColor: shadowColor,
            offset: shadowOffset,
            shadowRadius: shadowRadius,
            shadowOpacity: shadowOpacity
        )
    }
    
    private func setLoadingView(showShimmer: Bool) {
        foodPlateImageView.isShimmer(showShimmer, cornerRadius: 16.0)
        nameLabel.isShimmer(showShimmer, cornerRadius: 8.0)
        
        if !showShimmer {
            arrowImageView.isHidden = false
            preparationTimeLabel.isHidden = false
            setupContentView()
        } else {
            arrowImageView.isHidden = true
            preparationTimeLabel.isHidden = true
        }
    }
    
    func displayShimmers() {
        setLoadingView(showShimmer: true)
    }
    
    func buildCell(with recipe: Recipe) {
        setLoadingView(showShimmer: false)
        selectedRecipe = recipe
        nameLabel.text = recipe.name
        foodPlateImageView.contentMode = .scaleAspectFill
        foodPlateImageView.loadImageFromURL(with: recipe.image)
        preparationTimeLabel.text = recipe.preparationTime
    }
    
    @objc func recipeButtonTapped(_ gesture: UITapGestureRecognizer) {
        guard let recipe = selectedRecipe else { return }
        
        recipeAction?(recipe)
    }
}

extension RecipeCellView: ViewStylerProtocol {
    
    func configureViewStyles() {
        AppThemeManager.shared.applyTextMediumStyle(to: nameLabel)
        AppThemeManager.shared.applyP3Style(to: preparationTimeLabel, color: ColorManager.gray2)
    }
}
