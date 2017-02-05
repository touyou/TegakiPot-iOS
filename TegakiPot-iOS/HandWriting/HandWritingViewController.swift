//
//  HandWritingViewController.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import UIKit
import AEXML

class HandWritingViewController: UIViewController {
    var editpanel: Editpanel!
    var svg: AEXMLDocument?
    var delegate: EditQuestionDelegate!
    
    @IBOutlet weak var drawableView: UIView! {
        didSet {
            drawableView.layer.masksToBounds = false
            drawableView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
            drawableView.layer.shadowOpacity = 0.9
            drawableView.layer.shadowRadius = 2.0
            
            editpanel = Editpanel(CGRect(x: 0, y: 0, width: drawableView.frame.width, height: drawableView.frame.height), self)
            drawableView.addSubview(editpanel)
            editpanel.modechange(.freehand)
        }
    }
    
    @IBOutlet var undoBtn: UIButton! {
        didSet {
            undoBtn.isEnabled = false
        }
    }
    
    @IBOutlet var redoBtn: UIButton! {
        didSet {
            redoBtn.isEnabled = false
        }
    }
    
    @IBOutlet var modeButton: [UIButton]! {
        didSet {
            modeButton[0].isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func undo() {
        editpanel.undo()
    }
    @IBAction func redo() {
        editpanel.redo()
    }
    @IBAction func freehand() {
        for i in 0 ..< modeButton.count {
            modeButton[i].isEnabled = true
        }
        modeButton[0].isEnabled = false
        editpanel.modechange(.freehand)
    }
    @IBAction func line() {
        for i in 0 ..< modeButton.count {
            modeButton[i].isEnabled = true
        }
        modeButton[1].isEnabled = false
        editpanel.modechange(.line)
    }
    @IBAction func goodline() {
        for i in 0 ..< modeButton.count {
            modeButton[i].isEnabled = true
        }
        modeButton[2].isEnabled = false
        editpanel.modechange(.goodline)
    }
    @IBAction func rect() {
        for i in 0 ..< modeButton.count {
            modeButton[i].isEnabled = true
        }
        modeButton[3].isEnabled = false
        editpanel.modechange(.rect)
    }
    @IBAction func circle() {
        for i in 0 ..< modeButton.count {
            modeButton[i].isEnabled = true
        }
        modeButton[4].isEnabled = false
        editpanel.modechange(.circle)
    }
    @IBAction func save() {
        svg = editpanel.toSvg()
        dismiss(animated: true, completion: {
            self.delegate.endHandWriting(self.svg!)
        })
    }

    @IBAction func animate() {
        editpanel.animate()
    }
    // editpanel.stroke.color で色指定
    // editpanel.stroke.width で太さ指定
}

extension HandWritingViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
