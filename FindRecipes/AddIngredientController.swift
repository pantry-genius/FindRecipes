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
class AddIngredientController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, InputBarAccessoryViewDelegate{

    let cellId = "cellId"
    
    lazy var addBar : InputBarAccessoryView = {
        let bar = InputBarAccessoryView()
        bar.inputTextView.placeholder = "new ingredient item"
        bar.sendButton.title = "Add"
        //bar.setStackViewItems([], forStack: .bottom, animated: true)
        return bar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    var ingredients = [Ingredient]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40 + 8 + 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IngredientCell
        cell.ingredient = ingredients[indexPath.item]
        return cell
    }
    
    fileprivate func setUpNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(handleSubmit))
    
    }
    
    @objc func handleCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleSubmit() {
        let recipeRequest = RecipeRequest(info: ["ingredients": ingredients, "number": 10])
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
                    var missedIngredients = [String]()
                    for (_, subJson): (String, JSON) in subJson["missedIngredients"] {
                        missedIngredients.append(subJson["originalString"].stringValue)
                    }
                    var currentIngredients = [String]()
                    for (_, subJson): (String, JSON) in subJson["usedIngredients"] {
                        currentIngredients.append(subJson["originalString"].stringValue)
                    }
                    
                    var recipe = Recipe(["id" : id, "title": title, "image": imageUrl, "missing": missedIngredients, "current": currentIngredients])
                    instructionUrl = instructionUrl + id + "/information"
                    //let instructionParameter : Parameters = ["id" : id]
                    Alamofire.request(instructionUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: recipeRequest.getHeaders()).responseJSON(completionHandler: { (response) in
                        print(response.request)
                        if response.result.isSuccess {
                            let recipeDetailJson : JSON = JSON(response.result.value!)
                            let instructions = recipeDetailJson["instructions"].stringValue
                            print(instructions)
                            recipe.instructions = instructions
                            recipes.append(recipe)
                            if Int(key) == recipeJson.arrayValue.count - 1 {
                                let recipeController = RecipeController(collectionViewLayout: UICollectionViewFlowLayout())
                                self.navigationController?.pushViewController(recipeController, animated: true)
                                recipeController.recipes = recipes
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
                self.ingredients.append(Ingredient(name: firstResult.identifier) )
                self.collectionView.reloadData()
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
        ingredients.append(Ingredient(name: inputBar.inputTextView.text))
        collectionView.reloadData()
        addBar.inputTextView.text = nil
    }
    
    
    
    
    
    
}
