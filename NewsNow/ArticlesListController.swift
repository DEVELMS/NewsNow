//
//  ArticlesController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 11/09/16.
//
//

import UIKit

class ArticlesListController: UITableViewController {

    private var articles = [Article]()
    private var dao = ArticleDao()
    private var articleSelected = Article()
    
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
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 60))
        let title = UILabel()
        
        title.text = "Artigos"
        
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
                
            case "sgArticle":
                
                if let articleVC = segue.destinationViewController as? ArticleController {
                    
                    articleVC.article = articleSelected
                }
                
            default: break
                
            }
        }
    }
}
