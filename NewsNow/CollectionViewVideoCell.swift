//
//  CollectionViewVideoCell.swift
//  NewsNow
//
//  Created by Lucas M Soares on 05/11/16.
//
//

import UIKit

class CollectionViewVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    var video = Video()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(video: Video) {
        
        self.video = video
        
        title.text = video.description
        duration.text = video.duration
        
        setImage(video.thumbnail)
    }
    
    private func setImage(_ url: String) {
        
        Image.get(url: url, success: {
            image in
            
            self.background.image = image
        })
    }
}
