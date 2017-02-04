//
//  QuestionListViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import Alamofire

final class QuestionListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .white
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
            print(questions)
        })
    }
}

// MARK: - Collection View

extension QuestionListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionPreviewCell", for: indexPath) as! QuestionListCollectionViewCell
        
        let question = questions[indexPath.row]
//        cell.autherLabel.text = "by \(question.)"
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .day, .month], from: question.createdAt!)
        cell.yearLabel.text = "\(component.year)"
        cell.dateLabel.text = "\(component.month)/\(component.day)"
        cell.titleLabel.text = question.title
//        cell.voteLabel.text = "votes: \(question.)"
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// MARK: - Storyboard Instantiable

extension QuestionListViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
