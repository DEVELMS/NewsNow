//
//  ArticlesController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 11/09/16.
//
//

import UIKit

class ArticleListController: UITableViewController {

    private var articles = [Article]()
    private var dao = ArticleDao()
    private var articleSelected = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewAttributes()
        downloadContent()
    }
    
    private func setTableViewAttributes() {
        
        self.tableView.estimatedRowHeight = 270
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.barTintColor = .darkGrayColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
    }
    
    private func downloadContent() {
        
        dao.getArticles (
            
            success: {
                articles in
                
                self.articles = articles
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
        
        return articles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("articleCell", forIndexPath: indexPath) as! ArticleCell
        
        cell.setAttributes(articles[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        articleSelected = articles[indexPath.row]
        
        performSegueWithIdentifier("sgArticle", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let identifier = segue.identifier {
        
            switch identifier {
                
            case "sgArticle":
                
                if let articleVC = segue.destinationViewController as? ArticleController {
                    
                    articleVC.article = articleSelected
                }
                
            default: break
                
            }
        }
    }
}
