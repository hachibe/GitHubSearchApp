//
//  ViewModel.swift
//  GitHubSearchApp
//
//  Created by 坪内 征悟 on 2017/03/07.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

protocol ViewModel {
    associatedtype State
    
    var stateDidUpdate: ((State) -> Void)? { get set }
}
