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
    
    fileprivate func setAttributes() {
        
        self.tableView.estimatedRowHeight = 410
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = "Artigo"
        self.navigationController?.navigationBar.barTintColor = .darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as!  ArticleCell
        
        cell.setAttributes(article)
        
        return cell
    }

}
