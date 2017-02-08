//
//  Editpanel.swift
//  TegakiPot-iOS
//
//  Created by 松下祐介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import AEXML

// MARK: - Edit Panel

class EditPanel : UIView {
    unowned var controller: HandWritingViewController
    var geometry: Geometry
    var redoshapes: [Shape] = Array()
    var stroke: Stroke
    var fill: Fill
    var creation: Creation?
    
    enum Mode {
        case base
        case freehand
        case line
        case goodline
        case rect
        case circle
    }
    
    var mode: Mode = .base
    var creating: Bool {
        get { return creation != nil }
    }
    var undoable: Bool {
        get { return !geometry.shapes.isEmpty }
    }
    var redoable: Bool {
        get { return !redoshapes.isEmpty }
    }
    
    func modechange(_ mode: Mode) {
        creation?.bye()
        switch mode {
        case .base:
            break
        case .freehand:
            creation = FreehandCreation(self, stroke, fill)
        case .line:
            creation = LineCreation(self, stroke, fill)
        case .goodline:
            creation = GoodlineCreation(self, stroke, fill)
        case .rect:
            creation = RectCreation(self, stroke, fill)
        case .circle:
            creation = CircleCreation(self, stroke, fill)
        }
        self.mode = mode
    }
    
    func undo() {
        if !undoable {
            print ("error: not undoable!")
            return
        }
        redoshapes.append(popShape())
        controller.undoBtn.isEnabled = undoable
        controller.redoBtn.isEnabled = true
    }
    
    func redo() {
        if !redoable {
            print ("error: not redoable!")
            return
        }
        pushShape(redoshapes.popLast()!, false)
        controller.redoBtn.isEnabled = redoable
        controller.undoBtn.isEnabled = true
    }
    
    init(_ frame: CGRect, _ controller: HandWritingViewController) {
        self.controller = controller
        geometry = Geometry(frame.size, Pers(Double(frame.width)/40))
        stroke = Stroke(0.1, UIColor.red)
        fill = Fill(UIColor.clear)
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    init(_ frame: CGRect, _ controller: HandWritingViewController, _ svg: AEXMLDocument) {
        self.controller = controller
        geometry = Geometry(svg, frame.size, Pers(Double(frame.width)/40))
        stroke = Stroke(0.1, UIColor.red)
        fill = Fill(UIColor.clear)
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let creation = creation {
            let touch = touches.first!
            let p = touch.location(in:self) >| geometry.pers
            creation.touchbegan(p)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let creation = creation {
            let touch = touches.first!
            let p = touch.location(in:self) >| geometry.pers
            creation.touchmoved(p)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let creation = creation {
            let touch = touches.first!
            let p = touch.location(in:self) >| geometry.pers
            creation.touchended(p)
        }
    }
    
    override func draw(_: CGRect) {
        geometry.draw()
    }
    
    func pushShape(_ shape: Shape, _ clearredo: Bool = true) {
        geometry.shapes.append(shape)
        setNeedsDisplay()
        controller.undoBtn.isEnabled = true
        if clearredo {
            redoshapes = Array()
            controller.redoBtn.isEnabled = false
        }
    }
    
    @discardableResult func popShape() -> Shape {
        let res = geometry.shapes.popLast()!
        setNeedsDisplay()
        return res
    }
    
    func updateShape(_ shape: Shape) {
        let _ = geometry.shapes.popLast()
        geometry.shapes.append(shape)
        setNeedsDisplay()
    }
    
    func load(_ svg: AEXMLDocument) {
        geometry.load(svg, frame.size, Pers(Double(frame.width)/40))
        setNeedsDisplay()
    }
    
    func toSvg() -> AEXMLDocument {
        return geometry.toSvg()
    }
    
    func animate() {
        geometry.animate(layer, self)
        geometry.shapes = Array()
        setNeedsDisplay()
    }
}

// MARK: - Creation Protocol

protocol Creation {
    func touchbegan(_: Point)
    func touchmoved(_: Point)
    func touchended(_: Point)
    func bye()
}

// MARK: - Free Hand Line

class FreehandCreation : Creation {
    unowned var editpanel: EditPanel
    let stroke: Stroke
    let fill: Fill
    var freehand: Freehand?
    init(_ editpanel: EditPanel, _ stroke: Stroke, _ fill: Fill) {
        self.editpanel = editpanel
        self.stroke = stroke
        self.fill = fill
    }
    func touchbegan(_ p: Point) {
        bye()
        freehand = Freehand(stroke, fill, p)
        editpanel.pushShape(freehand!)
    }
    func touchmoved(_ p: Point) {
        if let freehand = freehand {
            freehand.addPoint(p, editpanel.geometry.pers)
            editpanel.updateShape(freehand)
        }
    }
    func touchended(_ p: Point) {
        if let freehand = freehand {
            freehand.addPoint(p, editpanel.geometry.pers)
            editpanel.updateShape(freehand)
        }
        freehand = nil
    }
    func bye() {
        if freehand != nil {
            editpanel.popShape()
        }
    }
}

// MARK: - Normal Line

class LineCreation : Creation {
    unowned var editpanel: EditPanel
    let stroke: Stroke
    let fill: Fill
    var line: Line?
    
    init(_ editpanel: EditPanel, _ stroke: Stroke, _ fill: Fill) {
        self.editpanel = editpanel
        self.stroke = stroke
        self.fill = fill
    }
    
    func touchbegan(_ p: Point) {
        bye()
        line = Line(stroke, fill, p, p)
        editpanel.pushShape(line!)
    }
    
    func touchmoved(_ p: Point) {
        if let line = line {
            line.end = p
            editpanel.updateShape(line)
        }
    }
    
    func touchended(_ p: Point) {
        if let line = line {
            line.end = p
            editpanel.updateShape(line)
        }
        line = nil
    }
    
    func bye() {
        if line != nil {
            editpanel.popShape()
        }
    }
}

// MARK: - Good Line

fileprivate func goodline(_ p: Point, _ q: Point) -> Point {
    let v = q - p
    if abs(v.dx) >= abs(v.dy) {
        return p + (v.dx, 0)
    } else {
        return p + (0, v.dy)
    }
}

class GoodlineCreation : Creation {
    unowned var editpanel: EditPanel
    let stroke: Stroke
    let fill: Fill
    var line: Line?
    
    init(_ editpanel: EditPanel, _ stroke: Stroke, _ fill: Fill) {
        self.editpanel = editpanel
        self.stroke = stroke
        self.fill = fill
    }
    
    func touchbegan(_ p: Point) {
        bye()
        line = Line(stroke, fill, p, p)
        editpanel.pushShape(line!)
    }
    
    func touchmoved(_ p: Point) {
        if let line = line {
            line.end = goodline(line.start, p)
            editpanel.updateShape(line)
        }
    }
    
    func touchended(_ p: Point) {
        if let line = line {
            line.end = goodline(line.start, p)
            editpanel.updateShape(line)
        }
        line = nil
    }
    
    func bye() {
        if line != nil {
            editpanel.popShape()
        }
    }
}

// MARK: - Rectangle

class RectCreation : Creation {
    unowned var editpanel: EditPanel
    let stroke: Stroke
    let fill: Fill
    var rect: Rect?
    
    init(_ editpanel: EditPanel, _ stroke: Stroke, _ fill: Fill) {
        self.editpanel = editpanel
        self.stroke = stroke
        self.fill = fill
    }
    
    func touchbegan(_ p: Point) {
        bye()
        rect = Rect(stroke, fill, p, (0,0))
        editpanel.pushShape(rect!)
    }
    
    func touchmoved(_ p: Point) {
        if let rect = rect {
            rect.diagonal = p - rect.origin
            editpanel.updateShape(rect)
        }
    }
    
    func touchended(_ p: Point) {
        if let rect = rect {
            rect.diagonal = p - rect.origin
            editpanel.updateShape(rect)
        }
        rect = nil
    }
    
    func bye() {
        if rect != nil {
            editpanel.popShape()
        }
    }
}

// MARK: - Circle

class CircleCreation : Creation {
    unowned var editpanel: EditPanel
    let stroke: Stroke
    let fill: Fill
    var circle: Oval?
    
    init(_ editpanel: EditPanel, _ stroke: Stroke, _ fill: Fill) {
        self.editpanel = editpanel
        self.stroke = stroke
        self.fill = fill
    }
    
    func touchbegan(_ p: Point) {
        bye()
        circle = Oval(stroke, fill, p, 0)
        editpanel.pushShape(circle!)
    }
    
    func touchmoved(_ p: Point) {
        if let circle = circle {
            let radius = dist(circle.center, p)
            circle.radius = (radius, radius)
            editpanel.updateShape(circle)
        }
    }
    
    func touchended(_ p: Point) {
        if let circle = circle {
            let radius = dist(circle.center, p)
            circle.radius = (radius, radius)
            editpanel.updateShape(circle)
        }
        circle = nil
    }
    
    func bye() {
        if circle != nil {
            editpanel.popShape()
        }
    }
}
