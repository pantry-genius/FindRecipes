//
//  RecipeDetailController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/2/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
class RecipeDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let sender = PushNotificationSender()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe?.ingredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! RecipeDetailTableViewCell
        cell.ingredient = recipe?.ingredients[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    var recipe : Recipe? {
        didSet {
            guard let recipe = recipe else {return}
            recipeImageView.loadImage(urlString: recipe.imageUrl)
            titleLabel.text = recipe.title
            //currentIngredientsTextView.text = "You currently have thes ingredients: \n\n" + recipe.currentIngredients.joined(separator: "\n")
            
            //missingIngredientsTextView.text = "You are missing these ingredients: \n\n" + recipe.missingIngredients.joined(separator: "\n")
            if missingIngredientsTextView.text == nil {
                missingIngredientsTextView.text = "None"
            }
            if recipe.instructions == "" {
                sourceUrlButton.setTitle(recipe.sourceUrl, for: .normal)
            } else {
                instructionTextView.text = recipe.instructions
            }
            //tableView.heightAnchor.constraint(equalToConstant: CGFloat(recipe.ingredients.count * 100)).isActive = true
            tableView.reloadData()
            
            
            //view.setNeedsDisplay()
        }
    }
    
    var saveAble : Bool? {
        didSet {
            if !saveAble! {
                navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    
    
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 800)
    
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
        tl.font = UIFont.boldSystemFont(ofSize: 20.0)
        tl.textAlignment = .center
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
        sub.addTarget(nil, action: #selector(openUrl), for: .touchUpInside)
        return sub
    }()
    
    @objc func openUrl() {
        UIApplication.shared.open(URL(string: recipe!.sourceUrl)!, options: [:], completionHandler: nil)
    }
    
    lazy var saveLabel: UILabel = {
        let savedLabel = UILabel()
        savedLabel.text = "Saved Successfully"
        savedLabel.font = UIFont.boldSystemFont(ofSize: 18)
        savedLabel.textColor = .white
        savedLabel.numberOfLines = 0
        savedLabel.textAlignment = .center
        savedLabel.backgroundColor = UIColor(white: 0, alpha: 0.3)
        savedLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 80)
        savedLabel.center = self.view.center
        return savedLabel
    }()
    
    lazy var tableView: UITableView = {
        let insideTableView = UITableView()
        
        return insideTableView
    }()
    
    let nutrientsButton : UIButton = {
       let nb = UIButton(type: .system)
        nb.setTitle("get nutritents info", for: .normal)
        nb.addTarget(nil, action: #selector(goToNutrientView), for: .touchUpInside)
        return nb
    }()
    
    @objc func goToNutrientView() {
        let recipeRequest = RecipeRequest(info: ["ingredients": "", "number": 10])

        var instructionUrl = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes"
        guard let id = recipe?.id else {return}
        let inUrl = instructionUrl + "/" + id + "/nutritionWidget.json"
        
        Alamofire.request(inUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: recipeRequest.getHeaders()).responseJSON(completionHandler: { (response) in
            
            if response.result.isSuccess {
                let nutritionalInfoJson : JSON = JSON(response.result.value!)
                let calories = nutritionalInfoJson["calories"].stringValue
                var bothArray = [nutritionalData]()
                var goodNutrients = [nutritionalData]()
                var badNutrients = [nutritionalData]()
                let nutrientController = NutrientsViewController()
                for (key,subJson):(String, JSON) in nutritionalInfoJson {
                    if( key == "bad"){
                        let badDictionary = subJson
                        for(subKey,subValue) in badDictionary{
                            let info = subValue
                            var percent  = ""
                            var amount = ""
                            var title = ""
                            for( name,value ) in info{
                                if( name == "percentOfDailyNeeds"){
                                    percent = value.stringValue
                                }
                                if( name == "amount"){
                                    amount = value.stringValue
                                }
                                if( name == "title" ){
                                    title = value.stringValue
                                }
                            }
                            var newNutritionalElement = nutritionalData(dailyIntake: percent, amount: amount, title: title, c:1)
                            if( title == "Calories"){
                                newNutritionalElement.color = 2
                            }
                            badNutrients.append(newNutritionalElement)
                            
                            //print( "What is the size in the method ?? ", self.nutritionalInfo.count )
                            
                        }// for every pair in the nad
                        
                        //nutrientController.badArray = badNutrients
                        
                    }//if the key is bad
                    
                    
                    if (key == "good") {
                        let goodDictionary = subJson
                        for(subKey,subValue) in goodDictionary{
                            let info = subValue
                            var percent  = ""
                            var amount = ""
                            var title = ""
                            for( name,value ) in info{
                                if( name == "percentOfDailyNeeds"){
                                    percent = value.stringValue
                                }
                                if( name == "amount"){
                                    amount = value.stringValue
                                }
                                if( name == "title" ){
                                    title = value.stringValue
                                }
                            }
                            let newNutritionalElement = nutritionalData(dailyIntake: percent, amount: amount, title: title, c:0)
                            goodNutrients.append(newNutritionalElement)
                            //print( "What is the size in the method ?? ", self.nutritionalInfo.count )
                        }
                        
                        for  index in 0 ..< badNutrients.count {
                            //print(index)
                            bothArray.append(goodNutrients[index])
                            bothArray.append(badNutrients[index])
                        }
                        print("------ SPLIT -----")
                        for  index in badNutrients.count..<goodNutrients.count {
                            //print(index)
                            bothArray.append(goodNutrients[index])
                            //bothArray.append(blank)
                        }
                        
                        nutrientController.bothArray = bothArray
                        
                         //nutrientController.goodArray = goodNutrients
                    }
                    
                   
                    
                }// end of nutritioanelInfoJson
                
               
                
                self.navigationController?.pushViewController(nutrientController, animated: true)
                
            }
            
        })//End AlamoFireRequest
        
    }//END getInstructions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(RecipeDetailTableViewCell.self, forCellReuseIdentifier: "cellId")
        
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(recipeImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(currentIngredientsTextView)
        containerView.addSubview(missingIngredientsTextView)
        containerView.addSubview(instructionTextView)
        //containerView.addSubview(sourceUrlButton)
        instructionTextView.addSubview(sourceUrlButton)
        containerView.addSubview(tableView)
        
        recipeImageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: containerView.frame.width)
        titleLabel.anchor(top: recipeImageView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        tableView.anchor(top: titleLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        //currentIngredientsTextView.anchor(top: titleLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        ///missingIngredientsTextView.anchor(top: currentIngredientsTextView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        instructionTextView.anchor(top: tableView.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 500)
        sourceUrlButton.anchor(top: instructionTextView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        //tableView.anchor(top: sourceUrlButton.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1000)
        containerView.addSubview(nutrientsButton)
        //nutrientsButton.anchor(top: sourceUrlButton.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        nutrientsButton.translatesAutoresizingMaskIntoConstraints = false
        nutrientsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nutrientsButton.widthAnchor.constraint(equalToConstant: 0).isActive = false
        nutrientsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        nutrientsButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    
    @objc func handleSave() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        guard let uid = Auth.auth().currentUser?.uid else {
            let loginController = LoginController()
            let navController = UINavigationController(rootViewController: loginController)
            self.present(navController, animated: true, completion: nil)
            navigationItem.rightBarButtonItem?.isEnabled = true
            return
        }
        let userRecipeRef = Database.database().reference().child("recipes").child(uid)
        let ref = userRecipeRef.childByAutoId()
        guard let ingredients = recipe?.ingredients else {return}
        //let ingredientsNames = recipe?.ingredients.map({$0.name})
        var ingredientArray = [[String: Any]]()
        for ingredi in ingredients {
            ingredientArray.append(["name" : ingredi.name, "imageUrl": ingredi.imageUrl, "missing": ingredi.missing])
        }
        let values = ["title": recipe?.title, "id" : recipe?.id, "imageUrl" : recipe?.imageUrl, "ingredients": ingredientArray, "instructions" : recipe?.instructions, "sourceUrl" : recipe?.sourceUrl, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("err uploading to firebase", err)
            }
            
            if let token = Messaging.messaging().fcmToken {
                self.sender.sendPushNotification(to: token, title: "saved", body: "saved successfully")
            }
            
            DispatchQueue.main.async {
                self.view.addSubview(self.saveLabel)
                self.saveLabel.layer.transform = CATransform3DMakeScale(0, 0, 0)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    self.saveLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                }, completion: { (completed) in
                    UIView.animate(withDuration: 0.5, delay: 0.75, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        self.saveLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                        self.saveLabel.alpha = 0
                        
                    }, completion: { (_) in
                        self.saveLabel.removeFromSuperview()
                    })
                })

            }
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        
    }
}
