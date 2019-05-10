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
    let currentIngredients : [String]
    let missingIngredients : [String]
    var instructions : String = ""
    var sourceUrl : String = ""
    init(_ info: [String: Any]) {
        id = info["id"] as? String ?? ""
        title = info["title"] as? String ?? ""
        imageUrl = info["image"] as? String ?? ""
        currentIngredients = info["current"] as? [String] ?? [String]()
        missingIngredients = info["missing"] as? [String] ?? [String]()
        //instructions = info["instructions"] as? String ?? ""
        //print(title, imageUrl, currentIngredients, missingIngredients, instructions)
        
        
    }
}
