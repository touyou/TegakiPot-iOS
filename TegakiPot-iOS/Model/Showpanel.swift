//
//  Showpanel.swift
//  TegakiPot-iOS
//
//  Created by 松下祐介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import AEXML

class Showpanel : UIView {
    let geometry: Geometry
    init(_ frame: CGRect, _ svg: AEXMLDocument) {
        geometry = Geometry(svg, frame.size, Pers(Pixels(frame.width)/40))
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func draw(_: CGRect) {
        geometry.draw()
    }
}
