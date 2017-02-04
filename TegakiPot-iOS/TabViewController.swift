//
//  ViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTab()
        
        loginChecked()
    }
    
    private func loginChecked() {
        let saveData = UserDefaults.standard
        
        if saveData.object(forKey: "login_user") == nil {
            present(LoginViewController.instantiateFromStoryboard(), animated: true, completion: nil)
        }
    }

    private func configureTab() {
        let mainViewController = UINavigationController(rootViewController: QuestionListViewController.instantiateFromStoryboard())
        mainViewController.tabBarItem = UITabBarItem(title: "Browse", image: nil, selectedImage: nil)
        
        let editViewController = UINavigationController(rootViewController: EditQuestionViewController.instantiateFromStoryboard())
        editViewController.tabBarItem = UITabBarItem(title: "Question", image: nil, selectedImage: nil)
        
        let userViewController = UINavigationController(rootViewController: UserViewController.instantiateFromStoryboard())
        userViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        
        viewControllers = [mainViewController, editViewController, userViewController]
    }
}

