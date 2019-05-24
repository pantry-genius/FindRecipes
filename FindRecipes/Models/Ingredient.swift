//
//  Ingredient.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/21/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import Foundation

struct Ingredient {
    let name: String
    let imageUrl: String
    let missing: Bool
    init(name: String, imageUrl: String?, missing: Bool) {
        self.name = name
        self.imageUrl = imageUrl ?? ""
        self.missing = missing
    }
}
