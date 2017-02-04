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



func + <K,V> (d: [K:V], e: [K:V]) -> [K:V] {
    var res = d
    for (k,v) in e {
        res[k] = v
    }
    return res
}
extension Double {
    func fmt(_ n: Int) -> String {
        return String(format:"%.2f",self)
    }
}



typealias Size = Double
typealias Pixels = Double
typealias Scalar = Double

typealias Point = (x: Size, y: Size)
typealias DPoint = (dx: Size, dy: Size)
func +(p: Point, v: DPoint) -> Point {
    return (p.x+v.dx, p.y+v.dy)
}
func +(v: DPoint, p: Point) -> Point {
    return (p.x+v.dx, p.y+v.dy)
}
func +(v: DPoint, w: DPoint) -> Point {
    return (v.dx+w.dx, v.dy+w.dy)
}
func -(p: Point, q: Point) -> DPoint {
    return (p.x-q.x, p.y-q.y)
}
func -(p: Point, v: DPoint) -> Point {
    return (p.x-v.dx, p.x-v.dx)
}
func -(v: DPoint, w: DPoint) -> DPoint {
    return (v.dx-w.dx, v.dy-w.dy)
}
func *(a: Scalar, v: DPoint) -> DPoint {
    return (a*v.dx, a*v.dy)
}
func *(v: DPoint, a: Scalar) -> DPoint {
    return (a*v.dx, a*v.dy)
}
func /(v: DPoint, a: Scalar) -> DPoint {
    return (v.dx/a, v.dy/a)
}
func norm(_ v: DPoint) -> Size {
    return sqrt(v.dx*v.dx+v.dy*v.dy)
}
func dist(_ p: Point, _ q: Point) -> Size {
    return norm(p-q)
}
func individe(_ p: Point, _ q: Point, _ a: Scalar, _ b: Scalar) -> Point {
    return ((p.x*b+q.x*a)/(a+b), (p.y*b+q.y*a)/(a+b))
}
func midpoint(_ p: Point, _ q: Point) -> Point {
    return individe(p,q,1,1)
}
typealias ConTrolTo = (con: Point, trol: Point, to: Point)
func interpolate(_ p0: Point, _ p1: Point, _ p2: Point, _ p3: Point) -> ConTrolTo {
    let c1 = midpoint(p0,p1)
    let c2 = midpoint(p1,p2)
    let c3 = midpoint(p2,p3)
    let l1 = dist(p0,p1)
    let l2 = dist(p1,p2)
    let l3 = dist(p2,p3)
    let m1 = individe(c1,c2,l1,l2)
    let m2 = individe(c2,c3,l2,l3)
    let smooth_value = 1.0
    return (p1 + (c2-m1) * smooth_value, p2 + (c2-m2) * smooth_value, p2)
}
class Pers {
    var origin: CGPoint
    var scale: Pixels
    init(_ origin: CGPoint, _ scale: Pixels) {
        self.origin = origin
        self.scale = scale
    }
}
infix operator <| : CastingPrecedence
func <|(p: Point, pers: Pers) -> CGPoint {
    return CGPoint(x: pers.origin.x + CGFloat(p.x * pers.scale), y: pers.origin.y + CGFloat(p.y * pers.scale))
}
func <|(v: DPoint, pers: Pers) -> CGSize {
    return CGSize(width: v.dx * pers.scale, height: v.dy * pers.scale)
}
infix operator >| : CastingPrecedence
func >|(p: CGPoint, pers: Pers) -> Point {
    return (Double(p.x-pers.origin.x)/pers.scale, Double(p.y-pers.origin.y)/pers.scale)
}
func >|(v: CGSize, pers: Pers) -> DPoint {
    return (Double(v.width)/pers.scale, Double(v.height)/pers.scale)
}



extension UIColor {
    // (0...255, 0...255, 0...255, 0...1)
    var rgba: (r: Int, g: Int, b: Int, a: Double) {
        get {
            var (r,g,b,a) = (CGFloat(0),CGFloat(0),CGFloat(0),CGFloat(0))
            getRed(&r,green:&g,blue:&b,alpha:&a)
            return (Int(r*255),Int(g*255),Int(b*255),Double(a))
        }
    }
    // (0...255, 0...255, 0...255, 0...1)
    convenience init (_ r: Int, _ g: Int, _ b: Int, _ a: Double) {
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a))
    }
    func toRgbaString() -> String {
        if self == UIColor.clear {
            return "none"
        } else {
            let (r,g,b,a) = self.rgba
            return String(format: "rgba(%d,%d,%d,%.2f)",r,g,b,a)
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
    convenience init(_ body: UIBezierPath, _ stroke: Stroke, _ fill: Fill) {
        self.init(body,stroke.color,fill.color)
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
}



protocol Shape {
    func rawpath(_: Pers) -> Rawpath
    func toXml() -> AEXMLElement
}
class Stroke {
    var width: Size
    var color: UIColor
    init(_ width: Size, _ color: UIColor) {
        self.width = width
        self.color = color
    }
    func toXmlAttrs() -> [String: String] {
        return ["stroke": color.toRgbaString(), "stroke-width": width.description]
    }
}
class Fill {
    var color: UIColor
    init(_ color: UIColor) {
        self.color = color
    }
    func toXmlAttrs() -> [String: String] {
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
    func addPoint(_ p: Point, _ pers: Pers) -> (added: Rawpath, draft: Rawpath) {
        let added = Rawpath(UIBezierPath(), stroke, fill)
        let draft = Rawpath(UIBezierPath(), stroke, fill)
        if beziers.isEmpty {
            let bezier = interpolate(start,start,p,p)
            beziers.append(bezier)
            draft.move(start,pers)
            draft.addBezier(bezier,pers)
        } else {
            let q = beziers.popLast()!.to
            if beziers.isEmpty {
                let bezier1 = interpolate(start,start,q,p)
                let bezier2 = interpolate(start,q,p,p)
                beziers.append(bezier1)
                beziers.append(bezier2)
                added.move(start,pers)
                added.addBezier(bezier1,pers)
                draft.move(q,pers)
                draft.addBezier(bezier2,pers)
            } else {
                let r = beziers.last!.to
                let s = beziers.count>1 ? beziers[beziers.count-2].to : start
                let bezier1 = interpolate(s,r,q,p)
                let bezier2 = interpolate(r,q,p,p)
                beziers.append(bezier1)
                beziers.append(bezier2)
                added.move(r,pers)
                added.addBezier(bezier1,pers)
                draft.move(q,pers)
                draft.addBezier(bezier2,pers)
            }
        }
        return (added,draft)
    }
    func rawpath(_ pers: Pers) -> Rawpath {
        let res = Rawpath(UIBezierPath(), stroke, fill)
        res.move(start,pers)
        for bezier in beziers {
            res.addBezier(bezier,pers)
        }
        return res
    }
    func toXml() -> AEXMLElement {
        var d = String(format:"M%.2f,%.2f",start.x,start.y)
        for bezier in beziers {
            d += String(format:"S%.2f,%.2f,%.2f,%.2f,%.2f,%.2f",
                        bezier.con.x,bezier.con.y,
                        bezier.trol.x,bezier.trol.y,
                        bezier.to.x,bezier.to.y)
        }
        return AEXMLElement(name: "path", value: nil, attributes:
            stroke.toXmlAttrs() + fill.toXmlAttrs() + ["d": d])
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
    func rawpath(_ pers: Pers) -> Rawpath {
        let res = Rawpath(UIBezierPath(), stroke, fill)
        res.move(start,pers)
        res.addLine(end,pers)
        return res
    }
    func toXml() -> AEXMLElement {
        return AEXMLElement(name: "rect", value: nil, attributes:
            stroke.toXmlAttrs() + fill.toXmlAttrs() +
                ["d": String(format:"M%.2f,%.2fL%.2f,%.2f",start.x,start.y,end.x,end.y)])
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
    func rawpath(_ pers: Pers) -> Rawpath {
        return Rawpath(UIBezierPath(rect: CGRect(origin:origin<|pers,size:diagonal<|pers)), stroke, fill)
    }
    func toXml() -> AEXMLElement {
        return AEXMLElement(name: "rect", value: nil, attributes:
            stroke.toXmlAttrs() + fill.toXmlAttrs() +
                ["x": origin.x.fmt(2), "y": origin.y.fmt(2), "rx": diagonal.dx.fmt(2), "ry": diagonal.dy.fmt(2)])
    }
}
class Circle : Shape {
    // 外接長方形を考える
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
    convenience init(_ stroke: Stroke, _ fill: Fill, _ center: Point, _ radius: Size) {
        self.init(stroke,fill,center,(radius,radius))
    }
    func rawpath(_ pers: Pers) -> Rawpath {
        return Rawpath(UIBezierPath(ovalIn: CGRect(origin:center-radius<|pers,size:radius*2<|pers)), stroke, fill)
    }
    func toXml() -> AEXMLElement {
        return AEXMLElement(name: "ellipse", value: nil, attributes:
            stroke.toXmlAttrs() + fill.toXmlAttrs() +
                ["cx": center.x.fmt(2), "cy": center.y.fmt(2), "rx": radius.dx.fmt(2), "ry": radius.dy.fmt(2)])

    }
}
