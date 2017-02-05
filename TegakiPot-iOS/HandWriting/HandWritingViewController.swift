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
    
    @IBOutlet var colorButton: [UIButton]!
    var colors = [MaterialColor.red.color, MaterialColor.purple.color, MaterialColor.blue.color, MaterialColor.green.color, MaterialColor.orange.color, MaterialColor.black.color]
    var selected = 0
    var sizeFlag = 0
    var sizeArray = [40.0, 80.0, 120.0]
    var centerPoint: CGPoint!
    
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
    
    // editpanel.stroke.color で色指定
    // editpanel.stroke.width で太さ指定
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for i in 0 ..< colorButton.count {
            colorButton[i].tag = i
            colorButton[i].frame.size = CGSize(width: 40.0, height: 40.0)
            colorButton[i].backgroundColor = colors[i]
        }
        
        centerPoint = CGPoint(x: colorButton[0].frame.origin.x + 20.0, y: colorButton[0].frame.origin.y + 20.0)
        colorButton[0].layer.cornerRadius = 20.0
        editpanel.stroke.color = colors[0]!
        editpanel.stroke.width = 0.1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapColorButton(_ sender: UIButton) {
        if sender.tag == selected {
            let aft = CGFloat(sizeArray[(sizeFlag + 1) % 3])
            sender.frame = CGRect(x: centerPoint.x - aft / 2, y: centerPoint.y - aft / 2,
                                  width: aft, height: aft)
            sender.layer.cornerRadius = aft / 2
            sizeFlag = (sizeFlag + 1) % 3
            editpanel.stroke.width = 0.1 * Double(sizeFlag + 1)
        } else {
            colorButton[selected].frame = CGRect(x: centerPoint.x - 20.0, y: centerPoint.y - 20.0,
                                              width: 40.0, height: 40.0)
            colorButton[selected].layer.cornerRadius = 0.0
            centerPoint = CGPoint(x: sender.frame.origin.x + 20.0,
                                  y: sender.frame.origin.y + 20.0)
            sender.layer.cornerRadius = 20.0
            selected = sender.tag
            sizeFlag = 0
            editpanel.stroke.color = colors[selected]!
        }
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
        print(svg!.xml)
        /*
        dismiss(animated: true, completion: {
            self.delegate.endHandWriting(self.svg!)
        })*/
    }

    @IBAction func animate() {
        editpanel.animate()
    }
}

extension HandWritingViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return String(describing: self)
    }
}
