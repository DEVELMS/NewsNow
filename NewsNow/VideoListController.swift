//
//  VideosController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 11/09/16.
//
//

import UIKit

class VideoListController: UITableViewController {
    
    private var videos = [Video]()
    private var dao = VideoDao()
    private var videoSelected = Video()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewAttributes()
        downloadContent()
    }
    
    private func setTableViewAttributes() {

        self.tableView.estimatedRowHeight = 250
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.barTintColor = .darkGrayColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("videoCell", forIndexPath: indexPath) as! VideoCell
        
        cell.setAttributes(videos[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        videoSelected = videos[indexPath.row]
        
        performSegueWithIdentifier("sgVideo", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
                
            case "sgVideo":
                
                if let videoVC = segue.destinationViewController as? VideoController {
                    
                    videoVC.video = videoSelected
                }
                
            default: break
                
            }
        }
    }
}
