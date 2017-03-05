//
//  Result.swift
//  GitHubSearchRepository
//
//  Created by 坪内 征悟 on 2017/03/04.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

//import Foundation

enum Result<T, Error : Swift.Error> {
    case success(T)
    case failure(Error)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}
