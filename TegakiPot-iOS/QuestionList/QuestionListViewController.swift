//
//  QuestionListViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

final class QuestionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
    }
    
    var questions: [Question] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchQuestion()
    }
    
    private func fetchQuestion() {
        TegakiPotAPI().getQuestions(success: { questions in
            self.questions = questions
            self.tableView.reloadData()
        })
    }
}

// MARK: - Table View

extension QuestionListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - Storyboard Instantiable

extension QuestionListViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
