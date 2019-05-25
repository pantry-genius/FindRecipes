//
//  nutritients.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/24/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import Foundation

struct Nutrient{
    
    var dailyIntake:String
    
    var amount:String
    
    var title:String
    
    
    
    init( d: String , a:String , t:String  ) {
        
        self.dailyIntake = d
        
        self.amount      = a
        
        self.title       = t
        
    }
    
}
