//
//  Recipe.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/27/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import Foundation

struct Recipe {
    let title : String
    let id : String
    let imageUrl : String
    //let currentIngredients : [Ingredient]
    //let missingIngredients : [Ingredient]
    let ingredients: [Ingredient]
    var instructions : String = ""
    var sourceUrl : String = ""
    let creationDate: TimeInterval
    init(_ info: [String: Any]) {
        id = info["id"] as? String ?? ""
        title = info["title"] as? String ?? ""
        imageUrl = info["imageUrl"] as? String ?? ""
        //currentIngredients = info["current"] as? [Ingredient] ?? [Ingredient]()
        //missingIngredients = info["missing"] as? [Ingredient] ?? [Ingredient]()
        ingredients = info["ingredients"] as? [Ingredient] ?? [Ingredient]()
        instructions = info["instructions"] as? String ?? ""
        sourceUrl = info["sourceUrl"] as? String ?? ""
        creationDate = info["creationDate"] as? TimeInterval ?? 0
        //instructions = info["instructions"] as? String ?? ""
        //print(title, imageUrl, currentIngredients, missingIngredients, instructions)
        
        
    }
}
