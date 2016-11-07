//
//  ImagesDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 06/11/16.
//
//

import SwiftyJSON

struct Image {
 
    static let cache = NSCache<NSString, UIImage>()
    
    static func get(url: String, success: @escaping (_ image: UIImage) -> Void) {
        
        if let cachedImage = cache.object(forKey: url as NSString) {
            return success(cachedImage)
        }
        
        Service.sharedInstance.APIRequestImage(url: url,
            success: { image in
                
                guard let downloadedImage = UIImage(data: (image as! Data)) else {
                    print("downloadedImage is not a valid image")
                    return
                }
                
                cache.setObject(downloadedImage, forKey: url as NSString)
                success(downloadedImage)
                
        }, failure: { failure in
            
                print("Não foi possível carregar uma imagem desta url: \(url)")
        })
    }
}
