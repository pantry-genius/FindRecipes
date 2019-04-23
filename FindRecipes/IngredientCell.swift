//
//  IngredientCell.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/21/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit

class IngredientCell: UICollectionViewCell {
    
    var ingredient: Ingredient? {
        didSet {
            guard let ingredient = ingredient else {return}
            textView.text = ingredient.name
        }
    }
    
    let textView: UITextView = {
       let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
        textView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: -4, paddingRight: -4, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
