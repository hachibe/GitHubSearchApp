//
//  TableViewController.swift
//  GitHubSearchApp
//
//  Created by 坪内 征悟 on 2017/03/04.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
//class SearchTableViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    
    var responseItems = [Repository]()
    let cellIdentifier = "cellID"

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        // 入力された検索クエリの取得
        guard let keyword = searchBar.text else {
            return
        }
        
        // APIクライアントの生成
        let client = GitHubClient()
        
        // リクエストの発行
        let request = GitHubAPI.SearchRepositories(keyword: keyword)
        
        // リクエストの送信
        client.send(request: request) { [weak self] result in
            switch result {
            case let .success(response):
                self?.responseItems = response.items
                self?.tableView.reloadData()
                
                // こうしないとセルに反映されない
                // http://qiita.com/usagimaru/items/e1cb82ae7f0ed75c8e63
                DispatchQueue.main.async {
                    let _ = self?.tableView.visibleCells
                }
            case let .failure(error):
                let alert = UIAlertController(title: "エラー", message: "\(error)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { action in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(action)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseItems.count / 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCellID", for: indexPath)
        let item = responseItems[indexPath.row]
        cell.textLabel?.text = item.owner.login + "/" + item.name
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

