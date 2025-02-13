//
//  IngredientCellView.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit

class IngredientCellView: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureViewStyles()
    }
    
    func buildCell(with ingredient: String) {
        ingredientLabel.text = ingredient
    }
}

extension IngredientCellView: ViewStylerProtocol {
    
    func configureViewStyles() {
        AppThemeManager.shared.applyP2Style(to: ingredientLabel, color: ColorManager.shared.gray2)
    }
}
