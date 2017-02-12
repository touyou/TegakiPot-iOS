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
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var solveLabel: UILabel!
    
    var showPanel: ShowPanel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setSvg(_ xml: String, _ width: CGFloat) {
        
        let xmlStr = "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"no\"?><svg xmlns=\"http://www.w3.org/2000/svg\" height=\"916.00\" width=\"1221.00\"><g transform=\"translate(0.00,0.00) scale(30.52)\">" + xml + "</g></svg>"
        
        do {
            let svg = try AEXMLDocument(xml: xmlStr)
            showPanel = ShowPanel(CGRect(x: 0, y: 0, width: width, height: width / 4.0 * 3.0), svg)
            drawBaseView.addSubview(showPanel)
            self.layoutIfNeeded()
        } catch {}
    }
}
