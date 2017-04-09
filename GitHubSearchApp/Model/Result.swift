//
//  Result.swift
//  GitHubSearchRepository
//
//  Created by Hachibe on 2017/03/04.
//  Copyright © 2017年 Masanori. All rights reserved.
//

enum Result<T, Error: Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
