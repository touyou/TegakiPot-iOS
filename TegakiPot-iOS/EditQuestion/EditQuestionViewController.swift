//
//  EditQuestionViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import AEXML

protocol EditQuestionDelegate {
    func endHandWriting(_ doc: AEXMLDocument)
}

class EditQuestionViewController: UIViewController, EditQuestionDelegate {
    
    @IBOutlet weak var fieldSegmentControll: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var svgString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func post() {
        let saveData = UserDefaults.standard
        let postedBy = saveData.object(forKey: DataKey.loginUser.rawValue) as? UInt64
        let tags = tagTextField.text?.components(separatedBy: ",") ?? []
        TegakiPotAPI().postQuestion(postedBy: postedBy ?? 0,
                                    selectedField: fieldSegmentControll.selectedSegmentIndex,
                                    tags: tags, title: titleTextField.text ?? "",
                                    description: descriptionTextView.text ?? "",
                                    svg: svgString ?? "",
                                    success: { _ in
                                        let alert = UIAlertController(title: "投稿完了", message: "投稿されました。", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                        self.present(alert, animated: true, completion: { _ in
                                            self.initView()
                                        })
        },
                                    failure: { _ in
                                        let alert = UIAlertController(title: "投稿失敗", message: "投稿に失敗しました。", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                        self.present(alert, animated: true, completion: nil)
        })
    }
    
    @IBAction func openTegakiView() {
        let viewController = HandWritingViewController.instantiateFromStoryboard()
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    func initView() {
        fieldSegmentControll.selectedSegmentIndex = 0
        titleTextField.text = ""
        tagTextField.text = ""
        descriptionTextView.text = ""
        svgString = ""
    }
    
    func endHandWriting(_ doc: AEXMLDocument) {
        svgString = doc.xml
    }
}

extension EditQuestionViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
