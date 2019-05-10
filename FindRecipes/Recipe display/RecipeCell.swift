//
//  RecipeCell.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/27/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    var recipeUrl: String? {
        didSet {
            guard let imageUrl = recipeUrl else {return}
            recipePhotoView.loadImage(urlString: imageUrl)
        }
    }
    
    let recipePhotoView : CustomImageView = {
       let rp = CustomImageView()
        rp.contentMode = .scaleAspectFill
        rp.clipsToBounds = true
        return rp
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(recipePhotoView)
        recipePhotoView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
