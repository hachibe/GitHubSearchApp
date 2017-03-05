//
//  JSONDecodable.swift
//  GitHubSearchRepository
//
//  Created by 坪内 征悟 on 2017/03/03.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

protocol JSONDecodable {
    init(json: Any) throws
}
