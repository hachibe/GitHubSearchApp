//
//  LoadingView.swift
//  GitHubSearchApp
//
//  Created by Hachibe on 2017/03/08.
//  Copyright © 2017年 Masanori. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    /// nibの基底viewをloadする
    class func loadNibView() -> LoadingView {
        let nib = UINib(nibName: "LoadingView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! LoadingView
    }
}
