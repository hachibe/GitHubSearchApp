//
//  LoadingView.swift
//  GitHubSearchApp
//
//  Created by 坪内 征悟 on 2017/03/08.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

import UIKit

class LoadingView : UIView {
    
    /// nibの基底viewをloadする
    class func loadNibView() -> LoadingView {
        let nib = UINib(nibName: "LoadingView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).first as! LoadingView
    }
}
