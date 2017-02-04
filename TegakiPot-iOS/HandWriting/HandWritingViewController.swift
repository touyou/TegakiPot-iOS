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
    
    @IBOutlet weak var drawableView: UIView! {
        didSet {
            drawableView.layer.masksToBounds = false
            drawableView.layer.shadowOffset = CGSize(width: 0.2, height: 0.2)
            drawableView.layer.shadowOpacity = 0.9
            drawableView.layer.shadowRadius = 2.0
            
            editpanel = Editpanel(drawableView.frame, self)
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
    
    @IBOutlet var modeButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
            
        })
    }
//    @IBAction func load() {
//        if let svg = svg {
//            editpanel.load(svg)
//        } else {
//            print("error: no svg!")
//        }
//    }
    // editpanel.stroke.color で色指定
    // editpanel.stroke.width で太さ指定
}

extension HandWritingViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
