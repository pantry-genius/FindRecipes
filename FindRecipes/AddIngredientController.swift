//
//  AddFoodController.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/21/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit
import CoreML
import Vision
class AddIngredientController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    let cellId = "cellId"
    
    override func viewDidLoad() {
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        collectionView.register(IngredientCell.self, forCellWithReuseIdentifier: cellId)
        setUpNavigationItems()
        
    }
    
    var ingredients = [Ingredient]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 40 + 8 + 8)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IngredientCell
        cell.ingredient = ingredients[indexPath.item]
        return cell
    }
    
    fileprivate func setUpNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera3")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleCamera))
    
    }
    
    @objc func handleCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[.originalImage] as? UIImage {
            guard let ciimage = CIImage(image: originalImage) else { fatalError("could not covert to ciiimage")}
            detect(image: ciimage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    private func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3_1_1().model) else { fatalError(" failed to load coreml model" )}
        let request = VNCoreMLRequest(model: model) { (request, err) in
            if let err = err {
                print("err making request", err)
                return
            }
            
            guard let result = request.results as? [VNClassificationObservation] else {fatalError("model failed to request image")}
            
            if let firstResult = result.first {
                self.ingredients.append(Ingredient(name: firstResult.identifier) )
                self.collectionView.reloadData()
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
    }
    
    
    
}
