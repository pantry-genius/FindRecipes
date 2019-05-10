//
//  RecipeRequest.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/25/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import Alamofire
class RecipeRequest {
    
    var info: [String:Any]
    
    init(info: [String: Any]) {
        self.info = info
    }
    
    func getHeaders() -> HTTPHeaders{
        let xMashapeHost = "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
        let xMashapeKey = "bc59c27cebmsha71cfb371bc4627p1afddbjsnf58ac3ca8faa"
        let headers: HTTPHeaders = ["X-RapidAPI-Host": xMashapeHost, "X-RapidAPI-Key": xMashapeKey]
        return headers
    }
    
    func getParameters() -> Parameters {
        var ingredientString = ""
        if let ingredients = info["ingredients"] as? [Ingredient] {
            for ingredient in ingredients {
                ingredientString = ingredientString + ingredient.name + ","
            }
            if !ingredientString.isEmpty {
                ingredientString.removeLast()                
            }
            print("ingredientstring is ", ingredientString)
        }
        let numberOfIngredients = info["number"] ?? 5
        let parameters : Parameters = ["ingredients": ingredientString, "number": numberOfIngredients]
        return parameters
    }
    
//    func getInstructionParameters() -> Parameters {
//        let id = info["id"]
//        let parameters : Parameters = ["id": id]
//        return parameters
//    }
    
}
