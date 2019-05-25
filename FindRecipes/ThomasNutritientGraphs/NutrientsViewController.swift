//
//  NutrientsViewController.swift
//  FindRecipes
//
//  Created by Thomas James Stuart on 5/25/19.
//  Copyright © 2019 Thomas James Stuart. All rights reserved.
//

import UIKit
class NutrientsViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    
//    
//    let n1 =  nutritionalData(dailyIntake: "19.15", amount: "382", title: "Calories")
//    let n2 =  nutritionalData(dailyIntake: "24.26", amount: "15g", title: "Fat")
//    let n3 =  nutritionalData(dailyIntake: "43.41", amount: "6g", title: "Saturated Fat")
//    let n4 =  nutritionalData(dailyIntake: "13.23", amount: "39g", title: "Carbohydrates")
//    let n5 = nutritionalData(dailyIntake: "0.87", amount: "0.78g", title: "Sugar")
//    let n6 = nutritionalData(dailyIntake: "19.36", amount: "58mg", title: "Cholesterol")
//    let n7 = nutritionalData(dailyIntake: "20.83", amount: "479mg", title: "Sodium")
//    
//    let g1 =  nutritionalData(dailyIntake: "43.3", amount: "21g", title: "Protein")
//    let g2 =  nutritionalData(dailyIntake: "70.75", amount: "1mg", title: "Manganese")
//    let g3 = nutritionalData(dailyIntake: "50.58", amount: "1mg", title: "Copper")
//    let g4 = nutritionalData(dailyIntake: "44.86", amount: "8mg", title: "Iron")
//    let g5 =  nutritionalData(dailyIntake: "35.91", amount: "0.72mg", title: "Vitamin B6")
//    let g6 = nutritionalData(dailyIntake: "33.63", amount: "27mg", title: "Vitamin C")
//    let g7 = nutritionalData(dailyIntake: "32.28", amount: "1129mg", title: "Potassium")
//    let g8 = nutritionalData(dailyIntake: "29.91", amount: "5mg", title: "Vitamin B3")
//    let g9 = nutritionalData(dailyIntake: "28.15", amount: "281mg", title: "Phosphorus" )
//    let g10 = nutritionalData(dailyIntake: "22.68", amount: "5g", title: "Fiber")
//    let g11 = nutritionalData(dailyIntake: "22.51", amount: "225mg", title: "Calcium")
//    let g12 = nutritionalData(dailyIntake: "18.62", amount: "74mg", title: "Magnesium")
//    
//    
//    let blank =  nutritionalData(dailyIntake: "100", amount: "100", title: "blank")
    
    //var collectionView: UICollectionView!
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(NutritionalDataCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        /*  END  OF COLLECTION VIEW FRAME AND CONTAINER  END */
        
        
        /*   MAKE 2 columns for the cells.  Size them as a square   */
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2 )/2 // 3 represents the number of posters on a row
        layout.itemSize = CGSize(width: width , height: width )
        /*   END 2 columns for the cells.  Size them as a square   */
        
        
        return collectionView
    }()
    let screenSize: CGRect = UIScreen.main.bounds
    private let cellReuseIdentifier = "NutritionalDataCollectionViewCell"
    
    
//    var badArray = [nutritionalData]()
//    //var goodArray = [nutritionalData]()
//    var goodArray : [nutritionalData]? {
//        didSet{
//            guard let goodArray = goodArray else {return}
//            for  index in 0 ... badArray.count-1 {
//                print(index)
//                bothArray.append(goodArray[index])
//                bothArray.append(badArray[index])
//            }
//            print("------ SPLIT -----")
//            for  index in badArray.count  ... goodArray.count-1 {
//                print(index)
//                bothArray.append(goodArray[index])
//                //bothArray.append(blank)
//            }
//            collectionView.reloadData()
//        }
//    }
    
    var bothArray : [nutritionalData]? {
        didSet {
            guard let bothArray = bothArray else {return}
            collectionView.reloadData()
        }
    }
    
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        // Load arrays with static data
//        badArray.append(n1)
//        badArray.append(n2)
//        badArray.append(n3)
//        badArray.append(n4)
//        badArray.append(n5)
//        badArray.append(n6)
//        badArray.append(n7)
//
//        goodArray.append(g1)
//        goodArray.append(g2)
//        goodArray.append(g3)
//        goodArray.append(g4)
//        goodArray.append(g5)
//        goodArray.append(g6)
//        goodArray.append(g7)
//
//        // ----- SPIT -------
//        goodArray.append(g8)
//        //blank
//        goodArray.append(g9)
//        //blank
//        goodArray.append(g10)
//        //blank
//        goodArray.append(g11)
//        //blank
//        goodArray.append(g12)
//        //blank
//
//        for  index in 0 ... badArray.count-1 {
//            print(index)
//            bothArray.append(goodArray[index])
//            bothArray.append(badArray[index])
//        }
//        print("------ SPLIT -----")
//        for  index in badArray.count  ... goodArray.count-1 {
//            print(index)
//            bothArray.append(goodArray[index])
//            //bothArray.append(blank)
//        }
        
        /*   MAKE THE COLLECTION VIEW FRAME AND CONTAINER */
//        let flowLayout = UICollectionViewFlowLayout()
//        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
//        collectionView.register(NutritionalDataCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.backgroundColor = UIColor.white
//        /*  END  OF COLLECTION VIEW FRAME AND CONTAINER  END */
//
//
//        /*   MAKE 2 columns for the cells.  Size them as a square   */
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        layout.minimumLineSpacing = 4
//        layout.minimumInteritemSpacing = 4
//
//        let width = (view.frame.size.width - layout.minimumInteritemSpacing*2 )/2 // 3 represents the number of posters on a row
//        layout.itemSize = CGSize(width: width , height: width )
//        /*   END 2 columns for the cells.  Size them as a square   */
//
//        self.view.addSubview(collectionView)
        
        self.view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(" What is the badArray count according to the cell count method ", bothArray?.count)
        return bothArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath as IndexPath) as! NutritionalDataCollectionViewCell
        
        /*           Test some values             */
        
        guard let bothArray = bothArray else {return cell}
        count = count + 1;
        cell.backgroundColor = UIColor.white
        /*    END    Test some values     END     */
        
        let  info = bothArray[indexPath.item]
        // ----------------------------------------------   //
        
        
        /*             Get the graph to display                 */
        cell.graph.configure( pv: Float( info.dailyIntake) ?? 1.0 ,gb: info.color )
        /*          END   Get the graph to display         END        */
        
        
        // Top label: amount
        cell.amountInGramsLabel.text = info.amount + " of "
        if( info.title == "Calories"){
            cell.amountInGramsLabel.text = info.amount
        }
        cell.amountInGramsLabel.textAlignment = .center
        cell.amountInGramsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        // Middle label: (most important)
        cell.nameOfNutritionLabel.text = info.title
        cell.nameOfNutritionLabel.textAlignment = .center
        cell.nameOfNutritionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        //Bottom Label: percentage of daily intake
        // first part
        cell.PDItopLabel.text = info.dailyIntake + " % of Normal "
        cell.PDItopLabel.textAlignment = .center
        cell.PDItopLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        //second part
        cell.PDIbottomLabel.text = " Daily Intake "
        cell.PDIbottomLabel.textAlignment = .center
        cell.PDIbottomLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        
        return cell
        
    }
    
    
    
}


