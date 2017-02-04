//
//  LoginViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login() {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
