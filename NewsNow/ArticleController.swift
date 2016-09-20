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
        
        self.title = "Artigo"
        self.navigationController?.navigationBar.barTintColor = .darkGrayColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        self.navigationController?.navigationBar.translucent = false
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as!  ArticleCell
        
        cell.setAttributes(article)
        
        return cell
    }

}
