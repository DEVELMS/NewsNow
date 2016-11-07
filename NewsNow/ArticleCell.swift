//
//  ArticleCell.swift
//  NewsNow
//
//  Created by Lucas M Soares on 19/09/16.
//
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var articleImage: UIImageView!
    @IBOutlet fileprivate weak var articTitle: UILabel!
    @IBOutlet fileprivate weak var articDescription: UILabel!
    
    func setAttributes(_ article: Article) {
        
        self.articTitle.text = article.title
        self.articDescription.text = article.description
        setImage(article.thumbnail)
    }
    
    fileprivate func setImage(_ url: String) {
        
        Image.get(url: url, success: {
            image in
            
            self.articleImage.image = image
        })
    }
}
