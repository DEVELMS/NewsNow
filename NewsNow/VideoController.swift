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
    fileprivate var dao = VideoDao()
    fileprivate let playerViewController = PlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationAttributes()
        setTitle()
        downloadContent()
    }
    
    fileprivate func setNavigationAttributes() {
    
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func setTitle() {
    
        self.title = video.description
    }
    
    fileprivate func setPlayerAttributes(_ cell: UITableViewCell) {
        
        playerViewController.video = video
        playerViewController.view.frame = cell.frame
        addChildViewController(playerViewController)
        cell.addSubview(playerViewController.view)
        playerViewController.didMove(toParentViewController: self)
    }
    
    fileprivate func downloadContent() {
    
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        }
        
        return video.related.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "video", for: indexPath)
            
            setPlayerAttributes(cell)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "videosCell", for: indexPath) as! VideoCell
        
        cell.setAttributes(video.related[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return tableView.frame.width * 0.56 //16:9
        }
        
        return 100
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let header = UIView()
            let title = UILabel()
            let headerHeight = CGFloat(40)
            let titleHeight = CGFloat(30)
            let x = CGFloat(20)
            let y = headerHeight / 2 - titleHeight / 2
            
            title.text = "Vídeos relacionados"
            
            title.textColor = .white
            header.backgroundColor = .lightGray
            
            header.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: headerHeight)
            title.frame = CGRect(x: x, y: y, width: header.frame.width - x * 2, height: titleHeight)
            
            header.addSubview(title)
            
            return header
        }
        else {
        
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            
            return 40
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            
            dao.getVideo(id: video.related[indexPath.row].id,
                         
                success: {
                    video in
                            
                    self.video = video
                    self.setTitle()
                    self.tableView.reloadData()
                    self.playerViewController.changeVideo(video: self.video)
                            
                }, fail: {
                    failure in
                    
                    print(failure)
            })
        }
    }
}
