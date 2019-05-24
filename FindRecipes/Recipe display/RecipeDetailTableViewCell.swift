//
//  RecipeDetailTableViewCell.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/21/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit

class RecipeDetailTableViewCell: UITableViewCell {
    
    
    let ingredientLabel : UITextView = {
        let iLabel = UITextView()
        iLabel.font = UIFont.systemFont(ofSize: 14)
        return iLabel
    }()
    
    var ingredient: Ingredient? {
        didSet {
            guard let imageUrl = ingredient?.imageUrl else {return}
            ingredientPhotoView.loadImage(urlString: imageUrl)
            ingredientLabel.text = ingredient?.name
            guard let missing = ingredient?.missing else {return}
            if missing {
                self.backgroundColor = .red
                ingredientLabel.backgroundColor = .red
            } else {
                self.backgroundColor = .green
                ingredientLabel.backgroundColor = .green
            }
        }
    }
    
    
    let ingredientPhotoView : CustomImageView = {
        let rp = CustomImageView()
        rp.contentMode = .scaleAspectFill
        rp.clipsToBounds = true
        return rp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(ingredientLabel)
        addSubview(ingredientPhotoView)
        ingredientPhotoView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 84, height: 84)
        ingredientPhotoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ingredientPhotoView.layer.cornerRadius = 84 / 2
        
        ingredientLabel.anchor(top: topAnchor, left: ingredientPhotoView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
