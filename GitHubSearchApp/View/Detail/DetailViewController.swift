//
//  DetailViewController.swift
//  GitHubSearchApp
//
//  Created by 坪内 征悟 on 2017/03/07.
//  Copyright © 2017年 Masanori Tsubouchi. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var label: UILabel!
    
    var repository: Repository!

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "login: \(repository.owner.login)\nname: \(repository.name)\nfull name: \(repository.fullName)"
    }
}
