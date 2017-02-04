//
//  QuestionDetailViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var svgArea: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    var id: UInt64? = nil
    var answer: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
    }
    
    private func fetchData() {
        guard let id = id else {
            print("no question")
            return
        }
        TegakiPotAPI().getQuestionDetail(id, success: { question in
            self.setViews(question)
        }, failure: { error in
            print("question fetch error")
        })
    }
    
    private func setViews(_ question: Question) {
        userNameLabel.text = question.postedBy?.userName
        var tags = ""
        question.tags?.forEach {
            tags += $0
            tags += ","
        }
        tagsLabel.text = tags
        titleLabel.text = question.title
        descriptionLabel.text = question.description
        answer = question.answers ?? []
        tableView.reloadData()
    }
}

// MARK: - TableView

extension QuestionDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension QuestionDetailViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
