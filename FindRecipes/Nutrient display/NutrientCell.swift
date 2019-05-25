//
//  NutrientCell.swift
//  FindRecipes
//
//  Created by wenlong qiu on 5/24/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit

class NutrientCell: UICollectionViewCell {
    
    var nutrient: [nutritionalData]? {
        didSet {
            guard let nutrient = nutrient else {return}
            //nutrientPhotoView.loadImage(urlString: imageUrl)
            handleAnimation()
        }
    }
    
    let nutrientPhotoView : CustomImageView = {
        let rp = CustomImageView()
        rp.contentMode = .scaleAspectFill
        rp.clipsToBounds = true
        return rp
    }()
    
    lazy var shapeLayber : CAShapeLayer = {
        let shapeLayber = CAShapeLayer()
        let center = self.center
        let circularPath = UIBezierPath(arcCenter: center, radius: frame.width / 2.3, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayber.path = circularPath.cgPath
        shapeLayber.strokeColor = UIColor.red.cgColor
        shapeLayber.lineWidth = 10
        shapeLayber.lineCap = CAShapeLayerLineCap.round
        
        shapeLayber.strokeEnd = 0
        
        return shapeLayber
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = UIView()
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        view.layer.addSublayer(shapeLayber)
        
        
//        addSubview(nutrientPhotoView)
//        nutrientPhotoView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayber.add(basicAnimation, forKey: "urSoBasic")
    }
}
