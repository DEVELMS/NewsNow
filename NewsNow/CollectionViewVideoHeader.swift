//
//  CollectionViewVideoHeader.swift
//  NewsNow
//
//  Created by Lucas M Soares on 05/11/16.
//
//

import UIKit

class CollectionViewVideoHeader: UICollectionReusableView {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(title: String) {
    
        self.title.text = title
    }
}
