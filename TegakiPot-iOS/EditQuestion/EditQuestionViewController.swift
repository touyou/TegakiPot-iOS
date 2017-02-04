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

        // Do any additional setup after loading the view.
        view.backgroundColor = MaterialColor.limeLighten4.color
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditQuestionViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
