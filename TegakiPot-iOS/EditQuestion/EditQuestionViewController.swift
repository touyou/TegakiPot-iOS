//
//  EditQuestionViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

class EditQuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openTegakiView() {
        present(HandWritingViewController.instantiateFromStoryboard(), animated: true, completion: nil)
    }
}

extension EditQuestionViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
