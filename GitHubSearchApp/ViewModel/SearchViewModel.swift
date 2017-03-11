//
//  SearchViewModel.swift
//  GitHubSearchApp
//
//  Created by 坪内 征悟 on 2017/03/07.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

import Foundation

class SearchViewModel : ViewModel {
    
    var stateDidUpdate: ((HTTPState<GitHubAPI.SearchRepositories.Response, GitHubClientError>) -> Void)?
    private var client: GitHubClient?
    
    /// リポジトリを検索する
    func searchRepositories(by keyword: String) {
        // APIクライアントの生成
        client = GitHubClient()
        
        // リクエストの発行
        let request = GitHubAPI.SearchRepositories(keyword: keyword)
        
        // リクエストの送信
        stateDidUpdate?(.loading)
        client?.send(request: request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self?.stateDidUpdate?(.success(response))
                case let .failure(error):
                    self?.stateDidUpdate?(.failure(error))
                }
            }
        }
    }
    
    /// 検索をキャンセルする
    func cancelSearch() {
        client?.cancel()
    }
}
