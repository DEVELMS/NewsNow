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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        video.related = ["video 1","video 2","video 3","video 4","video 5"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            
            return 1
        }
        
        return video.related.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell

        if indexPath.section == 0 {
            
            cell = tableView.dequeueReusableCellWithIdentifier("video", forIndexPath: indexPath)
            
            return cell
        }
        
        cell = tableView.dequeueReusableCellWithIdentifier("videosCell", forIndexPath: indexPath)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return tableView.frame.width * 0.56 //16:9
        }
        
        return 100
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 {
            
            return "Vídeos relacionados"
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            
            return 40
        }
        
        return 0
    }
    
    @IBAction func closeModal(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
