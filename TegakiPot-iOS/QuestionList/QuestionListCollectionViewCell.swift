//
//  QuestionListCollectionViewCell.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import AEXML

class QuestionListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var drawBaseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var solveLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setSvg(_ xml: String) {
        let width = drawBaseView.frame.height / 3.0 * 4.0
        let height = drawBaseView.frame.height
        
        do {
            let svg = try AEXMLDocument(xml: xml)
            let showPanel = Showpanel(CGRect(x: (width - height) / 2.0, y: 0, width: width, height: height), svg)
            drawBaseView.addSubview(showPanel)
        } catch {}
    }
}
