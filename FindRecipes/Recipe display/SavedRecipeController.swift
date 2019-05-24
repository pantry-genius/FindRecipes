//
//  SavedRecipeController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/20/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//
import UIKit
import Firebase
class SavedRecipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "recipeCell"
    
    var recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(signOut))
        collectionView.backgroundColor = .white
        //try? Auth.auth().signOut()
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "recipeCell")
        fetchUserRecipes()
    }
    
    @objc func signOut() {
        try! Auth.auth().signOut()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipeDetailController = RecipeDetailController()
        recipeDetailController.recipe = recipes[indexPath.item]
        recipeDetailController.saveAble = false
        navigationController?.pushViewController(recipeDetailController, animated: true)
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
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
        cell.recipeUrl = recipes[indexPath.item].imageUrl
        return cell
    }
    
    fileprivate func fetchUserRecipes() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("recipes").child(uid)
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            let recipe = Recipe(dictionary)
            self.recipes.insert(recipe, at: 0)
            self.collectionView.reloadData()
        }) {(err) in
            print("failed to fetch user recipes ", err)
        }
    }
    
}
