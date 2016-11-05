//
//  VideosController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 11/09/16.
//
//

import UIKit

class VideoListController: UITableViewController {
    
    fileprivate var videos = [Video]()
    fileprivate var dao = VideoDao()
    fileprivate var videoSelected = Video()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewAttributes()
        //downloadContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        downloadContent()
    }
    
    fileprivate func setTableViewAttributes() {

        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func downloadContent() {
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoCell
        
        cell.setAttributes(videos[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        videoSelected = videos[indexPath.row]
        
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
