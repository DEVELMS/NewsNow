//
//  VideoDao.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import SwiftyJSON

class VideoDao {

    func getVideo(parameters: [String: Any]? = nil, id: String, success: @escaping (_ video: Video) -> Void, fail: @escaping (_ error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(method: .GET, endPoint: .video, filters: [(name: "id", value: id)], parameters: parameters,
                                          
            success: { result in
                print("getVideo success")
                success(self.parseVideo(json: JSON(result)))
                                            
            }, failure: { failure in
                
                fail("Não foi possível carregar os videos.")
            }
        )
    }
    
    func getVideos(parameters: [String: Any]? = nil, success: @escaping (_ videos: [Video]) -> Void, fail: @escaping (_ error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(method: .GET, endPoint: .videos, parameters: parameters,
                                          
            success: { result in
                print("getVideos success")
                success(self.parseVideos(json: JSON(result)))
                                            
            }, failure: { failure in
                
                fail("Não foi possível carregar os videos.")
            }
        )
    }
    
    func getRelated(parameters: [String: Any]? = nil, id: String, success: @escaping (_ videos: [Video]) -> Void, fail: @escaping (_ error: String) -> Void) {
        
        Service.sharedInstance.APIRequest(method: .GET, endPoint: .related, filters: [(name: "id", value: id)], parameters: parameters,
                                          
            success: { result in
                                            
                success(self.parseVideos(json: JSON(result)))
                                            
            }, failure: { failure in
                
                fail("Não foi possível carregar os videos relacionados.")
            }
        )
    }
    
    fileprivate func parseVideos(json: JSON) -> [Video] {
        
        var videos = [Video]()
        
        for (_, video) in json {
            
            let video = parseVideo(json: video)
            
            videos.append(video)
        }
        
        return videos
    }
    
    fileprivate func parseVideo(json: JSON) -> Video {
        
        let id = json["id"].stringValue
        let url = json["url"].stringValue
        let description = json["description"].stringValue
        let thumbnail = json["thumbnail"].stringValue
        let duration = json["duration"].stringValue
        
        var video = Video(id: id, url: url, description: description, thumbnail: thumbnail, duration: duration)
        
        if json["related"].array != nil {
            
            video.related = parseVideos(json: json["related"])
        }
        
        return video
    }
}
