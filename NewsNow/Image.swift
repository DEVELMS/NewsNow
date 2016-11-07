//
//  ImagesDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 06/11/16.
//
//

import SwiftyJSON

struct Image {
 
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func get(url: String, success: @escaping (_ image: UIImage) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return success(cachedImage)
        }
        
        Service.sharedInstance.APIRequestImage(url: url,
            success: { image in
                
                let downloadedImage = self.parseImage(image as! Data)
                imageCache.setObject(downloadedImage, forKey: url as NSString)
                success(downloadedImage)
                
        }, failure: { failure in
            
                print("Não foi possível carregar uma imagem desta url: \(url)")
        })
    }
    
    static func parseImage(_ data: Data) -> UIImage {
        
        return UIImage(data: data)!
    }
}
