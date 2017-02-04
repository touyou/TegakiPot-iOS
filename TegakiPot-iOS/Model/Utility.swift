//
//  Utility.swift
//  TegakiPot-iOS
//
//  Created by 松下祐介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import QuartzCore

func + <K,V> (d: [K:V], e: [K:V]) -> [K:V] {
    var res = d
    for (k,v) in e {
        res[k] = v
    }
    return res
}
extension Array where Element: Equatable {
    mutating func remove(value: Element) {
        if let index = index(of: value) {
            remove(at: index)
        }
    }
}
extension Double {
    func fmt(_ n: Int) -> String {
        return String(format:"%.2f",self)
    }
}
extension CGFloat {
    init (_ string : String) {
        self.init(Double(string)!)
    }
    func fmt(_ n: Int) -> String {
        return String(format:"%.2f",Float(self))
    }
}
typealias Attrs = [String: String]
