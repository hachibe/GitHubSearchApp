//
//  JSONDecodeError.swift
//  GitHubSearchRepository
//
//  Created by Hachibe on 2017/03/03.
//  Copyright © 2017年 Masanori. All rights reserved.
//

enum JSONDecodeError: Error {
    case invalidFormat(json: Any)
    case missingValue(key: String, actualValue: Any?)
}
