//
//  ArticleCell.swift
//  NewsNow
//
//  Created by Lucas M Soares on 19/09/16.
//
//

import UIKit
import Kingfisher

class ArticleCell: UITableViewCell {
    
    @IBOutlet private weak var articleImage: UIImageView!
    @IBOutlet private weak var articTitle: UILabel!
    @IBOutlet private weak var articDescription: UILabel!
    
    func setAttributes(article: Article) {
        
        self.articTitle.text = article.title
        self.articDescription.text = article.description
        setImage(article.thumbnail)
    }
    
    private func setImage(url: String) {
        
        self.articleImage.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "placeholder-article"))
    }
}
