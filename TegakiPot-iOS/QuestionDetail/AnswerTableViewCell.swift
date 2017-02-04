//
//  AnswerTableViewCell.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/05.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var drawableArea: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    var goodCommit: (()->())!
    var badCommit: (()->())!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func goodBtn() {
        goodCommit()
    }
    
    @IBAction func badBtn() {
        badCommit()
    }
}
