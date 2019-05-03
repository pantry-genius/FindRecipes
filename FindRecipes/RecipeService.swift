//
//  RecipeService.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/25/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import Alamofire
class RecipeService {
    var baseUrl = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes"
    var recipeRequest: RecipeRequest
    
    init(_ recipeRequest: RecipeRequest, _ path: String?) {
        self.recipeRequest = recipeRequest
        if let path = path {
            baseUrl = baseUrl + "/" + path
        } 
    }
    
    func getPath() -> String {
        return baseUrl
    }
}
