//
//  EditAnswerViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/05.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import AEXML

class EditAnswerViewController: UIViewController, EditQuestionDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var questionTitle: String?
    var questionId: UInt64?
    var id: UInt64?
    var svgStr: String?

    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        if let idUser = saveData.object(forKey: DataKey.loginUser.rawValue) as? UInt64 {
            id = idUser
        }
        
        titleLabel.text = questionTitle
        
        configureNavBar()
    }
    
    private func configureNavBar() {
        let imageView =  UIImageView(frame: CGRect(x: ((navigationController?.navigationBar.frame.width)!/2) - (100/2), y: 0,
                                                   width: 100, height: (navigationController?.navigationBar.frame.height)! - 10.0))
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    @IBAction func handWrite() {
        let viewController = HandWritingViewController.instantiateFromStoryboard()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func post() {
        TegakiPotAPI().postAnswer(postedBy: id ?? 0, questionId: questionId ?? 0, description: textView.text ?? "", svg: svgStr ?? "", success: { _ in
            let alert = UIAlertController(title: "投稿完了", message: "投稿されました。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: { _ in
                self.navigationController?.popViewController(animated: true)
            })
        }, failure: { _ in
            let alert = UIAlertController(title: "投稿失敗", message: "投稿に失敗しました。", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func endHandWriting(_ doc: AEXMLDocument) {
        svgStr = doc.xml
    }
}

extension EditAnswerViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
