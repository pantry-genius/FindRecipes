//
//  NutritionalDataCollectionViewCell.swift
//  FindRecipes
//
//  Created by Thomas James Stuart on 5/25/19.
//  Copyright © 2019 Thomas James Stuart. All rights reserved.
//

import UIKit

class NutritionalDataCollectionViewCell: UICollectionViewCell {
    
    
    let graph: CircularGraph = {
        let graph = CircularGraph()
        graph.translatesAutoresizingMaskIntoConstraints = false
        return graph
    }()
    
    
    var nameOfNutritionLabel: UILabel = UILabel()
    var amountInGramsLabel: UILabel = UILabel()
    var PDItopLabel: UILabel = UILabel()
    var PDIbottomLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .white
        
        /*             Get the graph to display                 */
        addSubview(graph)
        graph.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        graph.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        graph.heightAnchor.constraint(equalToConstant: 100).isActive = true
        graph.widthAnchor.constraint(equalToConstant: 100).isActive = true
        /*          END   Get the graph to display         END        */
        
        
        // Top label: amount
        addSubview(amountInGramsLabel)
        bringSubviewToFront(amountInGramsLabel)
        let  amountInGramsLabelxOFFSET = 160.0/2
        let  amountInGramsLabelyOFFSET = (40.0/2) + (40)
        amountInGramsLabel.frame = CGRect(x: 101.5 - amountInGramsLabelxOFFSET, y: 101.5 - amountInGramsLabelyOFFSET, width: 160, height: 40)
        amountInGramsLabel.textColor = UIColor.white
        
        
        // Middle label: (most important)
        addSubview(nameOfNutritionLabel)
        bringSubviewToFront(nameOfNutritionLabel)
        let  nameOfNutritionLabelxOFFSET = 180.0/2
        let  nameOfNutritionLabelyOFFSET = 70.0/2
        nameOfNutritionLabel.frame = CGRect(x: 101.5 - nameOfNutritionLabelxOFFSET, y: 95.5 - nameOfNutritionLabelyOFFSET, width: 180, height: 70)
        nameOfNutritionLabel.textColor = UIColor.white
        
        
        //Bottom Label: percentage of daily intake
        // first part
        addSubview(PDItopLabel)
        bringSubviewToFront(PDItopLabel)
        let  PDItopLabelxOFFSET = 160.0/2
        let  PDItopLabelyOFFSET = 10.0
        PDItopLabel.frame = CGRect(x: 101.5 - PDItopLabelxOFFSET, y: 101.5 + PDItopLabelyOFFSET, width: 160, height: 40)
        PDItopLabel.textColor = UIColor.white
        
        //second part
        addSubview(PDIbottomLabel)
        bringSubviewToFront(PDIbottomLabel)
        let  PDIbottomLabelxOFFSET = 160.0/2
        let  PDIbottomLabelyOFFSET = 25.0
        PDIbottomLabel.frame = CGRect(x: 101.5 - PDIbottomLabelxOFFSET, y: 101.5 + PDIbottomLabelyOFFSET, width: 160, height: 40)
        PDIbottomLabel.textColor = UIColor.white
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
