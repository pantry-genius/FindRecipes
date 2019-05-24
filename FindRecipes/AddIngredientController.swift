//
//  AddFoodController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/21/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import CoreML
import Vision
import InputBarAccessoryView
import Alamofire
import SwiftyJSON
import SwipeCellKit
import Firebase
class AddIngredientController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, InputBarAccessoryViewDelegate{

    let cellId = "cellId"
    
    let userDefaults = UserDefaults.standard
    
    lazy var addBar : InputBarAccessoryView = {
        let bar = InputBarAccessoryView()
        bar.inputTextView.placeholder = "new ingredient item"
        bar.sendButton.title = "Add"
        //bar.setStackViewItems([], forStack: .bottom, animated: true)
        return bar
    }()
    
    
    let cameraButton : UIButton = {
       let button = UIButton(type: .system)
        button.setImage(UIImage(named: "camera3")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(nil, action: #selector(handleCamera), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsString = userDefaults.object(forKey: "ingredientsStrings") as? [String] ?? [String]()
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        collectionView.register(IngredientCell.self, forCellWithReuseIdentifier: cellId)
        addBar.delegate = self
        
        setUpNavigationItems()
        
    }
    
    override var inputAccessoryView: UIView? {
        return addBar
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    var ingredientsString = [String]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredientsString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40 + 8 + 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IngredientCell
        cell.delegate = self
        cell.ingredient = ingredientsString[indexPath.item]
        return cell
    }
    
    fileprivate func setUpNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "My Recipes", style: .plain
            , target: self, action: #selector(handleProfile))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
       navigationItem.titleView = cameraButton
            //UIBarButtonItem(image: UIImage(named: "camera3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
        
    }
    
    @objc func handleProfile() {
        if Auth.auth().currentUser == nil {
            navigationController?.pushViewController(LoginController(), animated: true)
        } else {
            let savedRecipeController = SavedRecipeController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(savedRecipeController, animated: true)
            savedRecipeController.navigationItem.title = "Saved Recipes"
            
        }
    }
    
    @objc func handleCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleSubmit() {
        let recipeRequest = RecipeRequest(info: ["ingredients": ingredientsString, "number": 10])
        let baseUrl = RecipeService(recipeRequest, "findByIngredients").getPath()
        var instructionUrl = RecipeService(recipeRequest, "").getPath()
        
        Alamofire.request(baseUrl, method: .get, parameters: recipeRequest.getParameters(), encoding: URLEncoding.default, headers: recipeRequest.getHeaders()).responseJSON { (response) in
            if response.result.isSuccess {
                var recipes = [Recipe]()
                let recipeJson : JSON = JSON(response.result.value!)
                for (key, subJson): (String, JSON) in recipeJson {
                    let id = subJson["id"].stringValue
                    let title = subJson["title"].stringValue
                    let imageUrl = subJson["image"].stringValue
                    var ingredients = [Ingredient]()
                    //var missedIngredients = [Ingredient]()
                    for (_, subJson): (String, JSON) in subJson["missedIngredients"] {
                        ingredients.append(Ingredient(name: subJson["originalString"].stringValue, imageUrl: subJson["image"].stringValue, missing: true))
                    }
                    //var currentIngredients = [Ingredient]()
                    for (_, subJson): (String, JSON) in subJson["usedIngredients"] {
                        ingredients.append(Ingredient(name: subJson["originalString"].stringValue, imageUrl: subJson["image"].stringValue, missing: false))
                    }
                    
                    var recipe = Recipe(["id" : id, "title": title, "imageUrl": imageUrl, "ingredients" : ingredients])
                    let inUrl = instructionUrl + id + "/information"
                    //let instructionParameter : Parameters = ["id" : id]
                    Alamofire.request(inUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: recipeRequest.getHeaders()).responseJSON(completionHandler: { (response) in
                        //print(response.request)
                        if response.result.isSuccess {
                            let recipeDetailJson : JSON = JSON(response.result.value!)
                            let instructions = recipeDetailJson["instructions"].stringValue
                            let sourceUrl = recipeDetailJson["sourceUrl"].stringValue
                            print(sourceUrl)
                            recipe.instructions = instructions
                            recipe.sourceUrl = sourceUrl
                            recipes.append(recipe)
                            if Int(key) == recipeJson.arrayValue.count - 1 {
                                let recipeController = RecipeController(collectionViewLayout: UICollectionViewFlowLayout())
                                self.navigationController?.pushViewController(recipeController, animated: true)
                                
                                recipeController.recipes = recipes
                                recipeController.navigationItem.title = "Recipes"
                            }
                        }
                    })
                    
                }
                
            } else {
                print("error to request recipe json: ", response.error)
            }
            
        }
        
    }
    

    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            guard let ciimage = CIImage(image: originalImage) else { fatalError("could not covert to ciiimage")}
            detect(image: ciimage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    private func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Food101().model) else { fatalError(" failed to load coreml model" )}
        let request = VNCoreMLRequest(model: model) { (request, err) in
            if let err = err {
                print("err making request", err)
                return
            }
            
            guard let result = request.results as? [VNClassificationObservation] else {fatalError("model failed to request image")}
            
            if let firstResult = result.first {
                self.ingredientsString.append(firstResult.identifier)
                self.collectionView.reloadData()
                self.userDefaults.set(self.ingredientsString, forKey: "ingredientsStrings")
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        ingredientsString.append(inputBar.inputTextView.text)
        collectionView.reloadData()
        self.userDefaults.set(self.ingredientsString, forKey: "ingredientsStrings")
        addBar.inputTextView.text = nil
    }
    
    
    
    
    
    
}

extension AddIngredientController: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexpath) in
            self.ingredientsString.remove(at: indexPath.item)
        }
        deleteAction.image = UIImage(named: "delete-icon")
        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
    
}
