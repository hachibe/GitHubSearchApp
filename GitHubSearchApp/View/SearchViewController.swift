//
//  SearchViewController.swift
//  GitHubSearchApp
//
//  Created by Hachibe on 2017/03/04.
//  Copyright © 2017年 Masanori. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,
                            UISearchBarDelegate,
                            UITableViewDataSource,
                            UITableViewDelegate,
                            UIScrollViewDelegate {

    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var repositories = [Repository]()
    var searchViewModel = SearchViewModel()
    let loadingView = LoadingView.loadNibView()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = true
        tableView.addSubview(loadingView)
        
        searchViewModel.stateDidUpdate = { [weak self] state in
            guard let me = self else {
                return
            }
            switch state {
            case .loading:
                me.showLoading()
            case let .success(response):
                me.hideLoading()
                me.updateRepositories(response.items)
            case let .failure(error):
                me.hideLoading()
                if error != GitHubClientError.cancel {
                    me.showSearchError(error)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loadingView.frame = tableView.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Private Methods
    
    /// 通信中を表示
    private func showLoading() {
        loadingView.isHidden = false
        tableView.isUserInteractionEnabled = false
    }
    
    /// 通信中を非表示
    private func hideLoading() {
        loadingView.isHidden = true
        tableView.isUserInteractionEnabled = true
    }
    
    /// リポジトリの表示を更新
    private func updateRepositories(_ repositories: [Repository]) {
        self.repositories = repositories
        tableView.reloadData()
        
        // こうしないとセルに反映されない
        // http://qiita.com/usagimaru/items/e1cb82ae7f0ed75c8e63
        DispatchQueue.main.async {
            _ = self.tableView.visibleCells
        }
    }
    
    /// 検索エラーを表示
    private func showSearchError(_ error: Error) {
        let message: String
        if case GitHubClientError.connectionError(_) = error {
            message = "通信に失敗し、検索結果を取得できませんでした"
        } else if case GitHubClientError.apiError(let apiError) = error {
            message = apiError.message
        } else {
            message = "\(error)"
        }
        let alert = UIAlertController(title: "検索エラー", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        // 入力された検索クエリの取得
        guard let keyword = searchBar.text else {
            return
        }
        
        searchViewModel.searchRepositories(by: keyword)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchViewModel.cancelSearch()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? DetailViewController {
            vc.repository = repositories[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
}
