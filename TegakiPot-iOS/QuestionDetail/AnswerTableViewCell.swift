//
//  AnswerTableViewCell.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/05.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import AEXML

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var badLabel: UILabel!
    @IBOutlet weak var drawBaseView: UIView!
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
    
    func setSvg(_ xml: String) {
        let width = drawBaseView.frame.height / 3.0 * 4.0
        let height = drawBaseView.frame.height
        let xmlStr = "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"no\"?><svg xmlns=\"http://www.w3.org/2000/svg\" height=\"916.00\" width=\"1221.00\"><g transform=\"translate(0.00,0.00) scale(30.52)\">" + xml + "</g></svg>"
        do {
            let svg = try AEXMLDocument(xml: xmlStr)
            let showPanel = Showpanel(CGRect(x: (width - height) / 2.0, y: 0, width: width, height: height), svg)
            drawBaseView.addSubview(showPanel)
            self.layoutIfNeeded()
        } catch {}
    }
}
