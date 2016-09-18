//
//  VideoCell.swift
//  NewsNow
//
//  Created by Lucas M Soares on 18/09/16.
//
//

import UIKit
import Kingfisher

class VideoCell: UITableViewCell {

    @IBOutlet private weak var videoImage: UIImageView!
    @IBOutlet private weak var videoDescription: UILabel!
    @IBOutlet private weak var duration: UILabel!
    
    var videoId = Int()
    
    func setAttributes(video: Video) {
        
        videoId = video.id
        
        self.videoDescription.text = video.description
        self.duration.text = video.duration
        setImage(video.thumbnail)
    }
    
    private func setImage(url: String) {
    
        self.videoImage.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "placeholder-video"))
    }
}
