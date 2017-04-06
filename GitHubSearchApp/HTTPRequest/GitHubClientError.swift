//
//  GitHubClientError.swift
//  GitHubSearchRepository
//
//  Created by 坪内 征悟 on 2017/03/03.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

enum GitHubClientError: Error, Equatable {
    // 通信に失敗
    case connectionError(Error)
    
    // レスポンスの解釈に失敗
    case responseParseError(Error)
    
    // APIからエラーレスポンスを受け取った
    case apiError(GitHubAPIError)
    
    // 通信キャンセル
    case cancel
    
    static func == (lhs: GitHubClientError, rhs: GitHubClientError) -> Bool {
        switch (lhs, rhs) {
        case (.cancel, .cancel):
            return true
        case (.connectionError(let l), .connectionError(let r)) where l._code == r._code:
            return true
        case (.responseParseError(let l), .responseParseError(let r)) where l._code == r._code:
            return true
        case (.apiError(let l), .apiError(let r)) where l._code == r._code:
            return true
        default:
            return false
        }
    }
}
