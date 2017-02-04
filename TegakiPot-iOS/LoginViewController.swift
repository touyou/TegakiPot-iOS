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
    
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func register() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login() {
        guard let email = emailTextField.text else {
            let alert = UIAlertController(title: "ログインエラー", message: "メールアドレスを入力してください。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard let password = passwordTextField.text else {
            let alert = UIAlertController(title: "ログインエラー", message: "パスワードを入力してください。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        TegakiPotAPI().postAuth(email: email, password: password, success: { response in
            self.saveData.set(response.id, forKey: DataKey.loginUser.rawValue)
            self.dismiss(animated: true, completion: nil)
        }, failure: { error in
            let alert = UIAlertController(title: "ログイン失敗", message: "ログインに失敗しました。メールアドレスとパスワードを確認してください。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

extension LoginViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
