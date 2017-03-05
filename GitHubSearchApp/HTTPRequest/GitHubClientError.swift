//
//  GitHubClientError.swift
//  GitHubSearchRepository
//
//  Created by 坪内 征悟 on 2017/03/03.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

enum GitHubClientError : Error {
    // 通信に失敗
    case connectionError(Error)
    
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    
    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
}
