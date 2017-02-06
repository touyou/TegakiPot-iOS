//
//  Math.swift
//  TegakiPot-iOS
//
//  Created by 松下祐介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import QuartzCore

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
    return (p.x-v.dx, p.y-v.dy)
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
func control(_ p: Point, _ q: Point, _ r: Point) -> Point {
    let dpq = dist(p,q)
    let dqr = dist(q,r)
    let s = dpq + dqr
    let t = s < 1e-6 ? 0 : 0.5 * dqr / s
    return q + 1.0 * t * (r-p)
}
typealias ConTrolTo = (con: Point, trol: Point, to: Point)
func interpolate(_ p0: Point, _ p1: Point, _ p2: Point, _ p3: Point) -> ConTrolTo {
    return (control(p0,p1,p2),control(p3,p2,p1),p2)
}
class Pers {
    var scale: Pixels
    var origin: CGPoint
    init(_ scale: Pixels, _ origin: CGPoint = CGPoint(x:0,y:0)) {
        self.scale = scale
        self.origin = origin
    }
}
infix operator <| : CastingPrecedence
func <|(p: Point, pers: Pers) -> CGPoint {
    return CGPoint(x: pers.origin.x + CGFloat(p.x*pers.scale), y: pers.origin.y + CGFloat(p.y*pers.scale))
}
func <|(v: DPoint, pers: Pers) -> CGSize {
    return CGSize(width: v.dx*pers.scale, height: v.dy*pers.scale)
}
func <|(a: Size, pers: Pers) -> CGFloat {
    return CGFloat(a*pers.scale)
}
infix operator >| : CastingPrecedence
func >|(p: CGPoint, pers: Pers) -> Point {
    return (Double(p.x-pers.origin.x)/pers.scale, Double(p.y-pers.origin.y)/pers.scale)
}
func >|(v: CGSize, pers: Pers) -> DPoint {
    return (Double(v.width)/pers.scale, Double(v.height)/pers.scale)
}
func >|(a: CGFloat, pers: Pers) -> Size {
    return Size(Double(a)/pers.scale)
}
