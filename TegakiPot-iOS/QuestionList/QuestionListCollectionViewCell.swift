//
//  QuestionListCollectionViewCell.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

class QuestionListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drawBaseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var solveLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
