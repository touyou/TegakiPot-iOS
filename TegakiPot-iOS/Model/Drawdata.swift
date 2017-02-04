//
//  Drawdata.swift
//  TegakiPot-iOS
//
//  Created by 松下祐介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import AEXML

extension UIColor {
    // (0...255, 0...255, 0...255, 0...1)
    var rgba: (r: Int, g: Int, b: Int, a: Double) {
        get {
            var (r,g,b,a) = (CGFloat(0),CGFloat(0),CGFloat(0),CGFloat(0))
            getRed(&r,green:&g,blue:&b,alpha:&a)
            return (Int(r*255),Int(g*255),Int(b*255),Double(a))
        }
    }
    convenience init (_ r: Int, _ g: Int, _ b: Int, _ a: Double) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a))
    }
    // rgba(0...255,0...255,0...255,0...1)
    func toRgbaString() -> String {
        let (r,g,b,a) = self.rgba
        return a==0 ? "none" : "rgba(\(r),\(g),\(b),\(a.fmt(2)))"
    }
    convenience init (_ rgbaString: String) {
        if rgbaString=="none" {
            self.init(0,0,0,0)
        } else {
            let ss = rgbaString.components(separatedBy: "(,)")
            self.init(Int(ss[1])!,Int(ss[2])!,Int(ss[3])!,Double(ss[4])!)
        }
    }
}
class Rawpath {
    var body: UIBezierPath
    var strokecolor: UIColor
    var fillcolor: UIColor
    init(_ body: UIBezierPath, _ strokecolor: UIColor = UIColor.clear, _ fillcolor: UIColor = UIColor.clear) {
        self.body = body
        self.strokecolor = strokecolor
        self.fillcolor = fillcolor
    }
    init(_ body: UIBezierPath, _ stroke: Stroke, _ fill: Fill) {
        self.body = body
        self.strokecolor = stroke.color
        self.fillcolor = fill.color
        self.body.lineWidth = CGFloat(stroke.width)
    }
    func move(_ p: Point, _ pers: Pers) {
        body.move(to: p <| pers)
    }
    func addBezier(_ tct: ConTrolTo, _ pers: Pers) {
        body.addCurve(to: tct.to <| pers, controlPoint1: tct.con <| pers, controlPoint2: tct.trol <| pers)
    }
    func addLine(_ p: Point, _ pers: Pers) {
        body.addLine(to: p <| pers)
    }
    func draw() {
        strokecolor.setStroke()
        fillcolor.setFill()
        body.stroke()
        body.fill()
    }
    func toLayer() -> CAShapeLayer {
        let res = CAShapeLayer()
        res.strokeColor = strokecolor.cgColor
        res.fillColor = fillcolor.cgColor
        res.path = body.cgPath
        return res
    }
}



protocol Shape {
    func toRawpath(_: Pers) -> Rawpath
    func toSvgElem() -> AEXMLElement
}
class Stroke {
    var width: Size
    var color: UIColor
    init(_ width: Size, _ color: UIColor) {
        self.width = width
        self.color = color
    }
    init(_ attrs: Attrs) {
        self.width = Size(attrs["stroke-width"]!)!
        self.color = UIColor(attrs["stroke"]!)
    }
    func toSvgAttrs() -> Attrs {
        return ["stroke": color.toRgbaString(), "stroke-width": "\(width)"]
    }
}
class Fill {
    var color: UIColor
    init(_ color: UIColor) {
        self.color = color
    }
    init(_ attrs: Attrs) {
        self.color = UIColor(attrs["fill"]!)
    }
    func toSvgAttrs() -> Attrs {
        return ["fill": color.toRgbaString()]
    }
}
class Freehand : Shape {
    var stroke: Stroke
    var fill: Fill
    var start: Point
    var beziers: [ConTrolTo]
    init (_ stroke: Stroke, _ fill: Fill, _ start: Point, _ beziers: [ConTrolTo] = Array()) {
        self.stroke = stroke
        self.fill = fill
        self.start = start
        self.beziers = beziers
    }
    func addPoint(_ p: Point, _ pers: Pers) {
        if beziers.isEmpty {
            let bezier = interpolate(start,start,p,p)
            beziers.append(bezier)
        } else {
            let q = beziers.popLast()!.to
            if beziers.isEmpty {
                let bezier1 = interpolate(start,start,q,p)
                let bezier2 = interpolate(start,q,p,p)
                beziers.append(bezier1)
                beziers.append(bezier2)
            } else {
                let r = beziers.last!.to
                let s = beziers.count>1 ? beziers[beziers.count-2].to : start
                let bezier1 = interpolate(s,r,q,p)
                let bezier2 = interpolate(r,q,p,p)
                beziers.append(bezier1)
                beziers.append(bezier2)
            }
        }
    }
    func toRawpath(_ pers: Pers) -> Rawpath {
        let res = Rawpath(UIBezierPath(), stroke, fill)
        res.move(start,pers)
        for bezier in beziers {
            res.addBezier(bezier,pers)
        }
        return res
    }
    func toSvgElem() -> AEXMLElement {
        var d = "M \(start.x.fmt(2)) \(start.y.fmt(2))"
        for bezier in beziers {
            d += "S \(bezier.con.x.fmt(2)) \(bezier.con.y.fmt(2)) \(bezier.trol.x.fmt(2)) \(bezier.trol.y.fmt(2)) \(bezier.to.x.fmt(2)) \(bezier.to.y.fmt(2))"
        }
        return AEXMLElement(name: "path", attributes:
            stroke.toSvgAttrs() + fill.toSvgAttrs() + ["d": d])
    }
}
class Line : Shape {
    var stroke: Stroke
    var fill: Fill
    var start: Point
    var end: Point
    init(_ stroke: Stroke, _ fill: Fill, _ start: Point, _ end: Point) {
        self.stroke = stroke
        self.fill = fill
        self.start = start
        self.end = end
    }
    func toRawpath(_ pers: Pers) -> Rawpath {
        let res = Rawpath(UIBezierPath(), stroke, fill)
        res.move(start,pers)
        res.addLine(end,pers)
        return res
    }
    func toSvgElem() -> AEXMLElement {
        return AEXMLElement(name: "path", attributes:
            stroke.toSvgAttrs() + fill.toSvgAttrs() +
                ["d": "M \(start.x.fmt(2)) \(start.y.fmt(2)) L \(end.x.fmt(2)) \(end.y.fmt(2))"])
    }
}
class Rect : Shape {
    var stroke: Stroke
    var fill: Fill
    var origin: Point
    var diagonal: DPoint
    init(_ stroke: Stroke, _ fill: Fill, _ origin: Point, _ diagonal: DPoint) {
        self.stroke = stroke
        self.fill = fill
        self.origin = origin
        self.diagonal = diagonal
    }
    func toRawpath(_ pers: Pers) -> Rawpath {
        return Rawpath(UIBezierPath(rect: CGRect(origin:origin<|pers,size:diagonal<|pers)), stroke, fill)
    }
    func toSvgElem() -> AEXMLElement {
        return AEXMLElement(name: "rect", attributes:
            stroke.toSvgAttrs() + fill.toSvgAttrs() +
                ["x": origin.x.fmt(2), "y": origin.y.fmt(2), "width": diagonal.dx.fmt(2), "height": diagonal.dy.fmt(2)])
    }
}
class Oval : Shape {
    var stroke: Stroke
    var fill: Fill
    var center: Point
    var radius: DPoint
    init(_ stroke: Stroke, _ fill: Fill, _ center: Point, _ radius: DPoint) {
        self.stroke = stroke
        self.fill = fill
        self.center = center
        self.radius = radius
    }
    init(_ stroke: Stroke, _ fill: Fill, _ center: Point, _ radius: Size) {
        self.stroke = stroke
        self.fill = fill
        self.center = center
        self.radius = (radius, radius)
    }
    func toRawpath(_ pers: Pers) -> Rawpath {
        return Rawpath(UIBezierPath(ovalIn: CGRect(origin:center-radius<|pers,size:radius*2<|pers)), stroke, fill)
    }
    func toSvgElem() -> AEXMLElement {
        return AEXMLElement(name: "ellipse", attributes:
            stroke.toSvgAttrs() + fill.toSvgAttrs() +
                ["cx": center.x.fmt(2), "cy": center.y.fmt(2), "rx": radius.dx.fmt(2), "ry": radius.dy.fmt(2)])
    }
}



class Geometry {
    var realsize: CGSize
    var pers: Pers
    var shapes: [Shape] = Array()
    init(_ realsize: CGSize, _ pers: Pers, _ shapes: [Shape] = Array()) {
        self.realsize = realsize
        self.pers = pers
        self.shapes = shapes
    }
    init(_ svg: AEXMLDocument, _ realsize: CGSize? = nil, _ pers: Pers? = nil) {
        self.realsize = CGSize(width: 0, height: 0)
        self.pers = Pers(Pixels(0))
        load(svg, realsize, pers)
    }
    func load(_ svg: AEXMLDocument, _ realsize: CGSize? = nil, _ pers: Pers? = nil) {
        let root = svg.root
        self.realsize = realsize ??
            CGSize(width:CGFloat(root.attributes["width"]!),height:CGFloat(root.attributes["height"]!))
        let subroot = root.children.first!
        let ss = subroot.attributes["transform"]!.components(separatedBy: "(,)")
        self.pers = pers ??
            Pers(Pixels(ss[4])!,CGPoint(x:CGFloat(ss[1]),y:CGFloat(ss[2])))
        self.shapes = Array<Shape>()
        for child in root.children {
            let attrs = child.attributes
            let stroke = Stroke(attrs)
            let fill = Fill(attrs)
            switch child.name {
            case "path":
                let d = attrs["d"]!.components(separatedBy: " ")
                let start = (Size(d[1])!,Size(d[2])!)
                if(d.count <= 3) {
                    shapes.append(Freehand(stroke,fill,start))
                } else if d[3] == "L" {
                    shapes.append(Line(stroke,fill,start,(Size(d[4])!,Size(d[5])!)))
                } else {
                    var curves = Array<ConTrolTo>()
                    let n = (d.count - 3) / 7
                    for i in 0..<n {
                        curves.append((
                            (Size(d[3+i*7+1])!,Size(d[3+i*7+2])!),
                            (Size(d[3+i*7+3])!,Size(d[3+i*7+4])!),
                            (Size(d[3+i*7+5])!,Size(d[3+i*7+6])!)))
                    }
                    shapes.append(Freehand(stroke,fill,start,curves))
                }
            case "rect":
                shapes.append(Rect(stroke, fill,
                                   (Size(attrs["x"]!)!,Size(attrs["y"]!)!),
                                   (Size(attrs["width"]!)!,Size(attrs["height"]!)!)))
            case "ellipse":
                shapes.append(Oval(stroke, fill,
                                   (Size(attrs["cx"]!)!,Size(attrs["cy"]!)!),
                                   (Size(attrs["rx"]!)!,Size(attrs["ry"]!)!)))
            default:
                print("Panel init svg unexpected tagname")
            }
        }
    }
    func toSvg() -> AEXMLDocument {
        let root = AEXMLElement(name: "svg", attributes:
            ["width": realsize.width.fmt(2), "height": realsize.height.fmt(2)])
        let subroot = AEXMLElement(name: "g", attributes:
            ["transform": "translate(\(pers.origin.x.fmt(2)),\(pers.origin.y.fmt(2))) scale(\(pers.scale.fmt(2)))"])
        root.addChild(subroot)
        for shape in shapes {
            subroot.addChild(shape.toSvgElem())
        }
        return AEXMLDocument(root: root)
    }
    func draw() {
        for shape in shapes {
            shape.toRawpath(pers).draw()
        }
    }
}
