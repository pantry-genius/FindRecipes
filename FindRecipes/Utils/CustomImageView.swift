//
//  CustomImageView.swift
//  FindRecipes
//
//  Created by wenlong qiu on 4/27/19.
//  Copyright © 2019 wenlong qiu. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    var lastURLUsedToLoad: String?
    func loadImage(urlString: String) {
        lastURLUsedToLoad = urlString
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("failed to fetch image with url", err)
                return
            }
            if url.absoluteString != self.lastURLUsedToLoad {
                return
            }
            
            guard let imageData = data else {return}
            let photoImage = UIImage(data: imageData)
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}
