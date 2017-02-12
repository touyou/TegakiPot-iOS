//
//  QuestionDetailViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import AEXML

class QuestionDetailViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var svgArea: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 20
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.allowsSelection = false
            
            tableView.register(cellType: AnswerTableViewCell.self)
        }
    }
    
    var id: UInt64? = nil
    var answers: [Answer] = []
    var question: Question?
    var showPanel: ShowPanel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
    }
    
    private func configureNavBar() {
        let imageView =  UIImageView(frame: CGRect(x: ((navigationController?.navigationBar.frame.width)!/2) - (100/2), y: 0,
                                                   width: 100, height: (navigationController?.navigationBar.frame.height)! - 10.0))
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    private func fetchData() {
        guard let id = id else {
            print("no question")
            return
        }
        TegakiPotAPI().getQuestionDetail(id, success: { question in
            self.question = question
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
        answers = question.answers ?? []
        tableView.reloadData()
        
        do {
            let svg = try AEXMLDocument(xml: question.svg ?? "")
            showPanel = ShowPanel(CGRect(x: 0, y: 0, width: svgArea.frame.width, height: svgArea.frame.height), svg)
            svgArea.addSubview(showPanel)
        } catch {}
    }
    
    @IBAction func editAnswer() {
        let viewController = EditAnswerViewController.instantiateFromStoryboard()
        viewController.questionTitle = question?.title
        viewController.questionId = id
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func animate() {
        showPanel?.animate()
    }
}

// MARK: - TableView

extension QuestionDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AnswerTableViewCell.self, for: indexPath)
        let answer = answers[indexPath.row]
        
        cell.descriptionLabel.text = answer.description
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        cell.dateLabel.text = formatter.string(from: answer.createdAt ?? Date())
        cell.goodLabel.text = "\(answer.good ?? 0)"
        cell.badLabel.text = "\(answer.bad ?? 0)"
        cell.setSvg(answer.svg ?? "")
        
        cell.goodCommit = {
//            TegakiPotAPI().postAnswerGood(answer.id, success: { _ in
//                
//            })
        }
        
        cell.badCommit = {
//            TegakiPotAPI().postAnswerBad(answer.id, success: { _ in
//                
//            })
        }
        
        return cell
    }
}

extension QuestionDetailViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
