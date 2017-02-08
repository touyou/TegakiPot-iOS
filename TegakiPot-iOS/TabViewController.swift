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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginChecked()
    }
    
    private func loginChecked() {
        let saveData = UserDefaults.standard
        
        if saveData.object(forKey: DataKey.loginUser.rawValue) == nil {
//        if saveData.object(forKey: DataKey.loginForTest.rawValue) == nil {
            print("login")
            present(LoginViewController.instantiateFromStoryboard(), animated: true, completion: nil)
        }
    }

    private func configureTab() {
        let mainViewController = UINavigationController(rootViewController: QuestionListViewController.instantiateFromStoryboard())
        mainViewController.tabBarItem = UITabBarItem(title: "Browse", image: #imageLiteral(resourceName: "browse_icon"), selectedImage: nil)
        
        let editViewController = UINavigationController(rootViewController: EditQuestionViewController.instantiateFromStoryboard())
        editViewController.tabBarItem = UITabBarItem(title: "Question", image: #imageLiteral(resourceName: "question_icon"), selectedImage: nil)
        
        let userViewController = UINavigationController(rootViewController: UserViewController.instantiateFromStoryboard())
        userViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home_icon"), selectedImage: nil)
        
        viewControllers = [mainViewController, editViewController, userViewController]
    }
}

