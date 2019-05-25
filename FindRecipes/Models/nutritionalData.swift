
//
//  Nutrient.swift
//  FindRecipes
//
//  Created by Thomas James Stuart on 5/24/19.
//  Copyright © 2019 Thomas James Stuart. All rights reserved.
//


import Foundation

struct nutritionalData{
    var dailyIntake:String
    var amount:String
    var title:String
    var color:Int
    
    init( dailyIntake: String , amount:String , title:String, c: Int  ) {
        self.dailyIntake = dailyIntake
        self.amount = amount
        self.title = title
        self.color = c
    }
}
