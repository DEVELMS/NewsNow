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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
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
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 60))
        let title = UILabel()
        
        title.text = "Vídeos"
        
        title.sizeToFit()
        
        let x = header.frame.width / 2 - title.frame.width / 2
        let y = header.frame.height / 2 - title.frame.height / 2 + 10
        
        title.frame = CGRect(x: x, y: y, width: title.frame.width, height: title.frame.height)
        
        title.textColor = .whiteColor()
        header.backgroundColor = .darkGrayColor()
        
        header.addSubview(title)
        
        return header
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
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
