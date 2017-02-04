//
//  TegakiPotAPI.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

class TegakiPotAPI {
    public init() {}
    
    struct GetQuestions: TegakiPotRequest {
        // MARK: RequestType
        typealias Response = Questions
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/questions.json"
        }
    }
    
}
