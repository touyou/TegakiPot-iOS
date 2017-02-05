//
//  UserViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var followBtn: UIButton! {
        didSet {
            followBtn.isHidden = true
        }
    }
    
    var userId: UInt64? {
        didSet {
            followBtn.isHidden = false
        }
    }
    var user: User?
    
    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = saveData.object(forKey: DataKey.loginUser.rawValue) as? UInt64 {
            TegakiPotAPI().getUserDetail(id, success: { user in
                self.userNameLabel.text = user.userName
                self.descriptLabel.text = user.selfIntroduction
                self.user = user
            }, failure: { error in
                print("get error")
            })
        }
        
        configureNavBar()
    }
    
    @IBAction func friend() {}
    
    private func configureNavBar() {
        let imageView =  UIImageView(frame: CGRect(x: ((navigationController?.navigationBar.frame.width)!/2) - (100/2), y: 0,
                                                   width: 100, height: (navigationController?.navigationBar.frame.height)! - 10.0))
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}

extension UserViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}

