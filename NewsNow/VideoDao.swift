//
//  VideoDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import SwiftyJSON

class VideoDao {

    func getVideo(parameters: [String: AnyObject]? = nil, id: Int, success: (video: Video) -> Void, fail: (error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(.GET, endPoint: .video, filters: [(name: "id", value: id)], parameters: parameters,
                                          
            success: { result in
                
                success(video: self.parseVideo(JSON(result)))
                                            
            }, failure: { failure in
                
                fail(error: "Não foi possível carregar os videos.")
            }
        )
    }
    
    func getVideos(parameters: [String: AnyObject]? = nil, success: (videos: [Video]) -> Void, fail: (error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(.GET, endPoint: .videos, parameters: parameters,
                                          
            success: { result in
                
                success(videos: self.parseVideos(JSON(result)))
                                            
            }, failure: { failure in
                
                fail(error: "Não foi possível carregar os videos.")
            }
        )
    }
    
    func getRelated(parameters: [String: AnyObject]? = nil, id: Int, success: (videos: [Video]) -> Void, fail: (error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(.GET, endPoint: .related, filters: [(name: "id", value: id)], parameters: parameters,
                                          
            success: { result in
                                            
                success(videos: self.parseVideos(JSON(result)))
                                            
            }, failure: { failure in
                
                fail(error: "Não foi possível carregar os videos relacionados.")
            }
        )
    }
    
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
        
        var video = Video(id: id, url: url, description: description, thumbnail: thumbnail, duration: duration)
        
        if json["related"].array != nil {
            
            video.related = parseVideos(json["related"])
        }
        
        return video
    }
}