//
//  CircularGraph.swift
//  FindRecipes
//
//  Created by Thomas James Stuart on 5/25/19.
//  Copyright © 2019 Thomas James Stuart. All rights reserved.
//

import UIKit


class CircularGraph: UIView {
    
    
    let shapeLayer = CAShapeLayer()
    
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configure(pv: Float, gb: Int) {
        
        
        let Center:CGPoint = CGPoint(x:50.7,y: 50.7)
        let circularPath = UIBezierPath(arcCenter: Center, radius: 90, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.green.cgColor
        if( gb == 1){
            shapeLayer.strokeColor = UIColor.red.cgColor
        }
        if( gb == 2 ){
            shapeLayer.strokeColor = UIColor.blue.cgColor
        }
        shapeLayer.lineWidth = 10
        print("value before animated ", pv)
        shapeLayer.strokeEnd = CGFloat(pv/100)
        layer.addSublayer(shapeLayer)
        
    }
    
    
}
