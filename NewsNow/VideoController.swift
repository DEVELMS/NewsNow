//
//  VideoController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 14/09/16.
//
//

import UIKit

class VideoController: UITableViewController {

    var video = Video()
    private var dao = VideoDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadContent()
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
    
    private func addCloseButton() -> UIButton {
    
        let size = CGFloat(40)
        let x = CGFloat(5)
        let y = CGFloat(20)
        
        let closeButton = UIButton(frame: CGRect(x: x, y: y, width: size, height: size))
        closeButton.setImage(UIImage(imageLiteral: "closeDown"), forState: .Normal)
        closeButton.imageView?.tintColor = .whiteColor()
        closeButton.addTarget(self, action: #selector(closeModal), forControlEvents: .TouchUpInside)
        
        return closeButton
    }

    @IBAction func closeModal(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
        
        let header = UIView()
        let title = UILabel()
        var headerHeight = CGFloat()
        let titleHeight = CGFloat(30)
        var x = CGFloat()
        var y = CGFloat()
        
        title.textColor = .whiteColor()
        
        if section == 0 {
            
            let closeButton = addCloseButton()
            title.text = video.description
            header.backgroundColor = .darkGrayColor()
            
            headerHeight = 80
            x = closeButton.frame.width + closeButton.frame.origin.x + 10
            y = headerHeight / 2 - titleHeight / 2 + 10
            
            header.addSubview(closeButton)
        }
        else {
            
            title.text = "Vídeos relacionados"
            header.backgroundColor = .lightGrayColor()
            
            headerHeight = 50
            x = 20
            y = headerHeight / 2 - titleHeight / 2 + 5
        }
        
        header.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: headerHeight)
        title.frame = CGRect(x: x, y: y, width: header.frame.width - x * 2, height: titleHeight)
        
        header.addSubview(title)
        
        return header
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return video.description
        }
        
        return "Vídeos relacionados"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 80
        }
        
        return 50
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        dao.getVideo(id: video.related[indexPath.row].id,
            success: {
                video in
                
                self.video = video
                self.tableView.reloadData()
                        
            }, fail: {
                failure in
                
                print(failure)
        })
    }
}
