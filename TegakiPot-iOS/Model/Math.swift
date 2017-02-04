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
    var scale: Pixels
    var origin: CGPoint
    init(_ scale: Pixels, _ origin: CGPoint = CGPoint(x:0,y:0)) {
        self.scale = scale
        self.origin = origin
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