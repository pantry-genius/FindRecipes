//
//  NutrientsController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/24/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit

import Firebase
class NutrientsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "nutrientCell"
    
    var nutrients: [nutritionalData]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        collectionView.backgroundColor = .white
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "nutrientCell")
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nutrients?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 1) / 2
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! NutrientCell
        //cell.nutrient = nutrients?[indexPath.item].nutrient
        return cell
    }
}
