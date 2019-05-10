//
//  RecipeDetailController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/2/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import Firebase

class RecipeDetailController: UIViewController {
    
    var recipe : Recipe? {
        didSet {
            guard let recipe = recipe else {return}
            recipeImageView.loadImage(urlString: recipe.imageUrl)
            titleLabel.text = recipe.title
            currentIngredientsTextView.text = "You currently have thes ingredients: \n\n" + recipe.currentIngredients.joined(separator: "\n")
            missingIngredientsTextView.text = "You are missing these ingredients: \n\n" + recipe.missingIngredients.joined(separator: "\n")
            if missingIngredientsTextView.text == nil {
                missingIngredientsTextView.text = "None"
            }
            if recipe.instructions == "" {
                sourceUrlButton.setTitle(recipe.sourceUrl, for: .normal)
            } else {
                instructionTextView.text = recipe.instructions
            }
            
            
            //view.setNeedsDisplay()
        }
    }
    
    
    
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 400)
    
    lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .black
        scrollView.frame = view.bounds
        scrollView.contentSize = contentViewSize
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    let recipeImageView: CustomImageView = {
        let view = CustomImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let instructionTextView: UITextView = {
        let itv = UITextView()
        itv.font = UIFont.systemFont(ofSize: 14)
        return itv
    }()
    
    let titleLabel: UILabel = {
       let tl = UILabel()
        tl.font = UIFont.systemFont(ofSize: 30)
        tl.numberOfLines = 0
        return tl
    }()
    
    let currentIngredientsTextView : UITextView = {
        let ciTextView = UITextView()
        ciTextView.font = UIFont.systemFont(ofSize: 14)
        return ciTextView
    }()
    
    let missingIngredientsTextView : UITextView = {
        let miTextView = UITextView()
        miTextView.font = UIFont.systemFont(ofSize: 14)
        return miTextView
    }()
    
    let sourceUrlButton: UIButton = {
        let sub = UIButton(type: .system)
        //sub.titleLabel?.text = "url"
        sub.addTarget(nil, action: #selector(openUrl), for: .touchUpInside)
        return sub
    }()
    
    @objc func openUrl() {
        UIApplication.shared.open(URL(string: recipe!.sourceUrl)!, options: [:], completionHandler: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(recipeImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(currentIngredientsTextView)
        containerView.addSubview(missingIngredientsTextView)
        containerView.addSubview(instructionTextView)
        //containerView.addSubview(sourceUrlButton)
        instructionTextView.addSubview(sourceUrlButton)
        
        recipeImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: containerView.frame.width)
        titleLabel.anchor(top: recipeImageView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        currentIngredientsTextView.anchor(top: titleLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        missingIngredientsTextView.anchor(top: currentIngredientsTextView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        instructionTextView.anchor(top: missingIngredientsTextView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 500)
        sourceUrlButton.anchor(top: instructionTextView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    
    @objc func handleSave() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userRecipeRef = Database.database().reference().child("recipes").child(uid)
        let ref = userRecipeRef.childByAutoId()
        
        let values = ["title": recipe?.title, "id" : recipe?.id, "imageUrl" : recipe?.imageUrl, "currentIngredients": recipe?.currentIngredients, "missingIngredients" : recipe?.missingIngredients, "]
        
    }
}
