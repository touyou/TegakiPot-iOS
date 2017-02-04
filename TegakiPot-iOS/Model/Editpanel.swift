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

class Editpanel : UIView {
    var geometry: Geometry
    var redoshapes: [Shape] = Array()
    var stable: StableView?
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
    var modechangeable: Bool {
        get { return !creating }
    }
    var undoable: Bool {
        get { return geometry.shapes.isEmpty }
    }
    var redoable: Bool {
        get { return redoshapes.isEmpty }
    }
    func modechange(mode: Mode) {
        if self.mode == mode { return }
        if !modechangeable {
            print ("error: not modechangeable!")
            return
        }
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
    }
    func redo() {
        if !redoable {
            print ("error: not redoable!")
            return
        }
        pushShape(redoshapes.popLast()!)
    }
    override init(frame: CGRect) {
        geometry = Geometry(frame.size, Pers(Double(frame.width)/40))
        stroke = Stroke(0.1, UIColor.black)
        fill = Fill(UIColor.clear)
        super.init(frame: frame)
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
    func pushShape(_ shape: Shape) {
        geometry.shapes.append(shape)
        stable?.removeFromSuperview()
        stable = StableView(frame, geometry)
    }
    @discardableResult func popShape() -> Shape {
        let res = geometry.shapes.popLast()!
        stable?.removeFromSuperview()
        stable = StableView(frame, geometry)
        return res
    }
    func updateShape(_ shape: Shape) {
        popShape()
        pushShape(shape)
    }
}
class StableView : UIView {
    let geometry: Geometry
    init(_ frame: CGRect, _ geometry: Geometry) {
        self.geometry = geometry
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_: CGRect) {
        geometry.draw()
    }
}

protocol Creation {
    func touchbegan(_: Point)
    func touchmoved(_: Point)
    func touchended(_: Point)
    func bye()
}
class FreehandCreation : Creation {
    unowned var editpanel: Editpanel
    let stroke: Stroke
    let fill: Fill
    var freehand: Freehand?
    init(_ editpanel: Editpanel, _ stroke: Stroke, _ fill: Fill) {
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
class LineCreation : Creation {
    unowned var editpanel: Editpanel
    let stroke: Stroke
    let fill: Fill
    var line: Line?
    init(_ editpanel: Editpanel, _ stroke: Stroke, _ fill: Fill) {
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
func goodline(_ p: Point, _ q: Point) -> Point {
    let v = q - p
    if abs(v.dx) >= abs(v.dy) {
        return p + (v.dx, 0)
    } else {
        return p + (0, v.dy)
    }
}
class GoodlineCreation : Creation {
    unowned var editpanel: Editpanel
    let stroke: Stroke
    let fill: Fill
    var line: Line?
    init(_ editpanel: Editpanel, _ stroke: Stroke, _ fill: Fill) {
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
    }
    func bye() {
        if line != nil {
            editpanel.popShape()
        }
    }
}
class RectCreation : Creation {
    unowned var editpanel: Editpanel
    let stroke: Stroke
    let fill: Fill
    var rect: Rect?
    init(_ editpanel: Editpanel, _ stroke: Stroke, _ fill: Fill) {
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
class CircleCreation : Creation {
    unowned var editpanel: Editpanel
    let stroke: Stroke
    let fill: Fill
    var circle: Oval?
    init(_ editpanel: Editpanel, _ stroke: Stroke, _ fill: Fill) {
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
    }
    func bye() {
        if circle != nil {
            editpanel.popShape()
        }
    }
}
