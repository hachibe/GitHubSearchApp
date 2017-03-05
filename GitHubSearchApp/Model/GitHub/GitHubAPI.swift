//
//  GitHubAPI.swift
//  GitHubSearchRepository
//
//  Created by 坪内 征悟 on 2017/03/03.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

final class GitHubAPI {
    struct SearchRepositories : GitHubRequest {
        let keyword: String
        
        // GitHubRequestが要求する連想型
        typealias Response = SearchResponse<Repository>
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/search/repositories"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
    
    struct SearchUsers : GitHubRequest {
        let keyword: String
        
        typealias Response = SearchResponse<User>
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/search/users"
        }
        
        var parameters: Any? {
            return ["q": keyword]
        }
    }
}
