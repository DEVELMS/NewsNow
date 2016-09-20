//
//  VideoController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 14/09/16.
//
//

import UIKit
import YouTubePlayer

class VideoController: UITableViewController {

    var video = Video()
    private var dao = VideoDao()
    private var videoPlayer: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        setTitle()
        downloadContent()
    }
    
    private func setAttributes() {
    
        self.navigationController?.navigationBar.barTintColor = .darkGrayColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        self.navigationController?.navigationBar.translucent = false
    }
    
    private func setTitle() {
    
        self.title = video.description
    }
    
    private func setLayoutAttributes(cell: UITableViewCell) {
    
        videoPlayer = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        videoPlayer.loadVideoID(video.id)
        
        cell.addSubview(videoPlayer)
        
        if videoPlayer.ready {
            
            if videoPlayer.playerState != YouTubePlayerState.Playing {
                
                videoPlayer.play()
            }
            else {
                
                videoPlayer.pause()
            }
        }
    }

    private func downloadContent() {
    
        dao.getRelated(id: video.id,
                       
            success: {
                videos in
                
                self.video.related = videos
                self.tableView.reloadData()
                
            }, fail: {
                failure in
                
                print(failure)
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        }
        
        return video.related.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("video", forIndexPath: indexPath)
            
            setLayoutAttributes(cell)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("videosCell", forIndexPath: indexPath) as! VideoCell
        
        cell.setAttributes(video.related[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return tableView.frame.width * 0.56 //16:9
        }
        
        return 100
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let header = UIView()
            let title = UILabel()
            let headerHeight = CGFloat(40)
            let titleHeight = CGFloat(30)
            let x = CGFloat(20)
            let y = headerHeight / 2 - titleHeight / 2
            
            title.text = "Vídeos relacionados"
            
            title.textColor = .whiteColor()
            header.backgroundColor = .lightGrayColor()
            
            header.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: headerHeight)
            title.frame = CGRect(x: x, y: y, width: header.frame.width - x * 2, height: titleHeight)
            
            header.addSubview(title)
            
            return header
        }
        else {
        
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            
            return 40
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section != 0 {
            
            dao.getVideo(id: video.related[indexPath.row].id,
                         
                success: {
                    video in
                            
                    self.video = video
                    self.setTitle()
                    self.tableView.reloadData()
                            
                }, fail: {
                    failure in
                    
                    print(failure)
            })
        }
    }
}
