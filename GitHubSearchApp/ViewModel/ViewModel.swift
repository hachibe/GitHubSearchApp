//
//  ViewModel.swift
//  GitHubSearchApp
//
//  Created by Hachibe on 2017/03/07.
//  Copyright © 2017年 Masanori. All rights reserved.
//

protocol ViewModel {
    associatedtype State
    
    var stateDidUpdate: ((State) -> Void)? { get set }
}
