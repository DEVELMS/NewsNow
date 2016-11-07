//
//  VideosController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 11/09/16.
//
//

import UIKit

class VideoListController: UITableViewController, SelectingCollectionVideo {
    
    fileprivate var videos = [Video]()
    fileprivate var dao = VideoDao()
    fileprivate var videoSelected = Video()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewAttributes()
        downloadContent()
    }
    
    private func setTableViewAttributes() {

        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private func downloadContent() {
    
        dao.getVideos (
            success: {
                videos in
                
                self.videos = videos
                self.tableView.reloadData()
            
            }, fail: {
                failure in
                
                print(failure)
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return videos.count
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellCollection.identifier, for: indexPath) as! VideoCellCollection
            
            cell.setup(videos: videos)
            cell.delegate = self
            
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.identifier, for: indexPath) as! VideoCell
            
            cell.setAttributes(videos[indexPath.row])
            
            return cell
            
        default: return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        videoSelected = videos[indexPath.row]
        
        performSegue(withIdentifier: "sgVideo", sender: nil)
    }
    
    // MARK: - SelectingCollectionVideo
    
    func collectionVideoSelected(video: Video) {
    
        videoSelected = video
        
        performSegue(withIdentifier: "sgVideo", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
                
            case "sgVideo":
                
                if let videoVC = segue.destination as? VideoController {
                    
                    videoVC.video = videoSelected
                }
                
            default: break
                
            }
        }
    }
}
