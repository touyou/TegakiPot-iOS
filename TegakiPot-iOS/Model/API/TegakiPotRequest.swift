//
//  TegakiPotRequest.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki
import APIKit

protocol TegakiPotRequest: Request {}

extension TegakiPotRequest {
    var baseURL: URL {
        return URL(string: "http://")!
    }
}

extension TegakiPotRequest where Response: Decodable {
    internal func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}

