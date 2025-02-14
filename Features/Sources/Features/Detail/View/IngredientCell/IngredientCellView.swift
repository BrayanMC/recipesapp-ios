//
//  IngredientCellView.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 12/02/25.
//

import UIKit
import CommonManagers
import DesignSystem

class IngredientCellView: UITableViewCell {
    
    @IBOutlet weak var indicatorImageView: UIImageView!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Task {
            await setupView()
        }
    }
    
    private func setupView() {
        configureViewStyles()
        indicatorImageView.image = ImageManager.shared.image(named: ImageNames.icCheckGreenCircle)
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
