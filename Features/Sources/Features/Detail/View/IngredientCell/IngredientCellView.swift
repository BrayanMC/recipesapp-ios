//
//  IngredientCellView.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit
import CommonManagers
import UIComponents

class IngredientCellView: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Task {
            await setupView()
        }
    }
    
    private func setupView() {
        configureViewStyles()
    }
    
    func buildCell(with ingredient: String) {
        ingredientLabel.text = ingredient
    }
}

extension IngredientCellView: ViewStylerProtocol {
    
    func configureViewStyles() {
        AppThemeManager.shared.applyP2Style(to: ingredientLabel, color: ColorManager.gray2)
    }
}
