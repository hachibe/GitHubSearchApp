//
//  HTTPState.swift
//  GitHubSearchApp
//
//  Created by 坪内 征悟 on 2017/03/07.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

enum HTTPState<T, Error: Swift.Error> {
    case loading
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
