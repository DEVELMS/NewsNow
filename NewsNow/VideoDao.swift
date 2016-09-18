//
//  VideoDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import SwiftyJSON

class VideoDao {

    func getVideos(parameters: [String: AnyObject]? = nil, success: (videos: [Video]) -> Void, fail: (error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(.GET, endPoint: .videos, parameters: parameters,
                                          
            success: { result in
                
                success(videos: self.parseVideos(JSON(result)))
                                            
            }, failure: { failure in
                
                fail(error: "Não foi possível carregar os videos.")
            }
        )
    }
    
//    func getRelated(parameters: [String: AnyObject]? = nil, filters: [(name: String, value: AnyObject)], success: (videos: [Video]) -> Void, fail: (error: String) -> Void) {
//        
//        Service.sharedInstance.APIRequest(.GET, endPoint: .videos, parameters: parameters,
//                                          
//            success: { result in
//                                            
//                success(videos: self.parseVideos(JSON(result)))
//                                            
//            }, failure: { failure in
//                
//                fail(error: "Não foi possível carregar os videos relacionados.")
//            }
//        )
//    }
    
    private func parseVideos(json: JSON) -> [Video] {
        
        var videos = [Video]()
        
        for (_, video) in json {
            
            let video = parseVideo(video)
            
            videos.append(video)
        }
        
        return videos
    }
    
    private func parseVideo(json: JSON) -> Video {
        
        let id = json["id"].intValue
        let url = json["url"].stringValue
        let description = json["description"].stringValue
        let thumbnail = json["thumbnail"].stringValue
        let duration = json["duration"].stringValue
        
        let video = Video(id: id, url: url, description: description, thumbnail: thumbnail, duration: duration)
        
        return video
    }
}