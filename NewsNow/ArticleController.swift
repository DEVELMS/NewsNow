//
//  ArticleController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 14/09/16.
//
//

import UIKit

class ArticleController: UITableViewController {
    
    var article = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
    }
    
    private func setAttributes() {
        
        self.tableView.estimatedRowHeight = 410
        self.tableView.rowHeight = UITableViewAutomaticDimension
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
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as!  ArticleCell
        
        cell.setAttributes(article)
        
        cell.addSubview(addCloseButton())
        
        return cell
    }

}
