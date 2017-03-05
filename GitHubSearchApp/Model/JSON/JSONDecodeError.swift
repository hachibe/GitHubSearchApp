//
//  JSONDecodeError.swift
//  GitHubSearchRepository
//
//  Created by 坪内 征悟 on 2017/03/03.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

enum JSONDecodeError : Error {
    case invalidFormat(json: Any)
    case missingValue(key: String, actualValue: Any?)
}
