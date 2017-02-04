//
//  TegakiPotError.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

struct TegakiPotError: Error {
    let message: String
    
    init(statusCode: Int) {
        switch statusCode {
        case 200:
            message = "success"
        case 401:
            message = "unauthorized"
            
        default:
            message = "Unknown Error code=\(statusCode)"
        }
    }
}
