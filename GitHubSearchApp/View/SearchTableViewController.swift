//
//  SearchTableViewController.swift
//  GitHubSearchApp
//
//  Created by 坪内 征悟 on 2017/03/04.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Properties
    
    var repositories = [Repository]()

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
                self?.repositories = response.items
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
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCellID", for: indexPath)
        if repositories.count <= indexPath.row {
            assertionFailure("indexPath.row exceeds count of repositories.")
            return cell
        }
        let item = repositories[indexPath.row]
        cell.textLabel?.text = item.owner.login + "/" + item.name
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? DetailViewController {
            vc.repository = repositories[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

