//
//  ImageCache.swift
//  stargazer
//
//  Created by Marco Celestino on 23/03/2021.
//

import UIKit

class ImageCache{

    static let shared = ImageCache()

    private let cached = NSCache<NSString, UIImage>()

    func image(for key: String) -> UIImage?{
        if let cacheImage = cached.object(forKey: key as NSString) {
            return cacheImage
        }
        return nil
    }

    func cache(image: UIImage?, for key: String){
        guard let image = image else {return}
        self.cached.setObject(image, forKey: key as NSString)
    }
}
