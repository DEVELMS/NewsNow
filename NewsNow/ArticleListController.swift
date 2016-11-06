//
//  ArticlesController.swift
//  NewsNow
//
//  Created by Lucas M Soares on 11/09/16.
//
//

import UIKit

class ArticleListController: UITableViewController {

    fileprivate var articles = [Article]()
    fileprivate var dao = ArticleDao()
    fileprivate var articleSelected = Article()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewAttributes()
        downloadContent()
    }
    
    fileprivate func setTableViewAttributes() {
        
        self.tableView.estimatedRowHeight = 270
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    fileprivate func downloadContent() {
        
        dao.getArticles (
            
            success: {
                articles in
                
                Delay.now {
                    self.articles = articles
                    self.tableView.reloadData()
                }
                
            }, fail: {
                failure in
                
                print(failure)
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.setAttributes(articles[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        articleSelected = articles[indexPath.row]
        
        performSegue(withIdentifier: "sgArticle", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
        
            switch identifier {
                
            case "sgArticle":
                
                if let articleVC = segue.destination as? ArticleController {
                    
                    articleVC.article = articleSelected
                }
                
            default: break
                
            }
        }
    }
}
