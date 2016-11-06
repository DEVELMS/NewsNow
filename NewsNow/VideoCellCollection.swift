//
//  VideoCellCollection.swift
//  NewsNow
//
//  Created by Lucas M Soares on 05/11/16.
//
//

import UIKit

class VideoCellCollection: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collection: UICollectionView!
    
    var header = CollectionViewVideoHeader()
    var videos = [Video]()
    var delegate: SelectingCollectionVideo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCollectionAttributes()
    }
    
    private func setCollectionAttributes() {
    
        collection.delegate = self
        collection.dataSource = self
    }
    
    func setup(videos: [Video]) {
        self.videos = videos
        collection.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    internal func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == "UICollectionElementKindSectionHeader" {
            
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewVideoHeader.identifier, for: indexPath) as! CollectionViewVideoHeader
            
            header.set(title: "Mais relevantes")
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewVideoCell.identifier, for: indexPath) as! CollectionViewVideoCell
        
        cell.setup(video: videos[indexPath.row])
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let delegate = delegate else {
            print("selectingCollectionVideo delegate not setted")
            return
        }
        
        delegate.collectionVideoSelected(video: videos[indexPath.row])
    }

}
