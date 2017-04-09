//
//  JSONDecodable.swift
//  GitHubSearchRepository
//
//  Created by Hachibe on 2017/03/03.
//  Copyright © 2017年 Masanori. All rights reserved.
//

protocol JSONDecodable {
    init(json: Any) throws
}
