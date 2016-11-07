//
//  VideoCell.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet fileprivate weak var videoImage: UIImageView!
    @IBOutlet fileprivate weak var videoDescription: UILabel!
    @IBOutlet fileprivate weak var duration: UILabel!
    
    func setAttributes(_ video: Video) {
        
        self.videoDescription.text = video.description
        self.duration.text = video.duration
        setImage(video.thumbnail)
    }
    
    fileprivate func setImage(_ url: String) {
    
        Image.get(url: url, success: {
            image in
            
            self.videoImage.image = image
        })
    }
}
