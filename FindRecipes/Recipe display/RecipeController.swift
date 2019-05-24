//
//  RecipeController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/27/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import Firebase
class RecipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "recipeCell"
    
    var recipes: [Recipe]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        collectionView.backgroundColor = .white
        
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "recipeCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeDetailController = RecipeDetailController()
        recipeDetailController.recipe = recipes?[indexPath.item]
        navigationController?.pushViewController(recipeDetailController, animated: true)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecipeCell
        cell.recipeUrl = recipes?[indexPath.item].imageUrl
        return cell
    }
    
//    fileprivate func fetchUserRecipes() {
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        let ref = Database.database().reference().child("recipes").child(uid)
//        ref.queryOrdered(byChild: "creationDate").observe(.childAdded) { (snapshot) in
//            guard let dictionary = snapshot.value as? [String: Any] else {return}
//            
//            
//        }
//    }

}
