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
            collectionView.backgroundColor = UIColor(hexString: "#f7faeaff")
            collectionView.register(cellType: QuestionListCollectionViewCell.self)
        }
    }
    
    var questions: [Question] = []
    var reloadBtn: UIBarButtonItem!
    
    let images = [#imageLiteral(resourceName: "chem"), #imageLiteral(resourceName: "lang"), #imageLiteral(resourceName: "math")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchQuestion()
    }
    
    private func fetchQuestion() {
        TegakiPotAPI().getQuestions(success: { questions in
            self.questions = questions
            self.collectionView.reloadData()
        })
    }
    
    func refresh() {
        fetchQuestion()
    }
    
    private func configureNavBar() {
        reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = reloadBtn
        
        let imageView =  UIImageView(frame: CGRect(x: ((navigationController?.navigationBar.frame.width)!/2) - (100/2), y: 0,
                                              width: 100, height: (navigationController?.navigationBar.frame.height)! - 10.0))
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
}

// MARK: - Collection View

extension QuestionListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: QuestionListCollectionViewCell.self, for: indexPath)
        
        let question = questions[indexPath.row]
        let nanashi = "名無しさん"
        cell.autherLabel.text = "by \(question.postedBy?.userName ?? nanashi)"
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .day, .month], from: question.createdAt!)
        cell.yearLabel.text = "\(component.year!)"
        cell.dateLabel.text = "\(component.month!)/\(component.day!)"
        cell.titleLabel.text = question.title
        cell.voteLabel.text = "♥ \(question.votes!)"
        if question.isSolved ?? false {
            cell.solveLabel.text = "solved"
            cell.solveLabel.backgroundColor = UIColor(hexString: "#5ed055ca")
        } else {
            cell.solveLabel.text = "unsolved"
            cell.solveLabel.backgroundColor = UIColor(hexString: "#d05568ca")
        }
        
        cell.imageView.image = images[indexPath.row % 3]
        
//        cell.setSvg(question.svg ?? "")
        
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 5.0
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio = CGFloat(3.0/4.0)
        return CGSize(width: view.frame.width / 4.5, height: view.frame.width / 4.5 * ratio)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let question = questions[indexPath.row]
        
        let viewController = QuestionDetailViewController.instantiateFromStoryboard()
        viewController.id = question.id
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Storyboard Instantiable

extension QuestionListViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
