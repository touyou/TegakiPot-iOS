//
//  ContributionStruct.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki

import Himotoki

// MARK: - Contribution
public struct Contribution {
    public var field: Field
    public var score: Int
}

extension Contribution: Decodable {
    public static func decode(_ e: Extractor) throws -> Contribution {
        return try Contribution(
            field: e <| "field",
            score: e <| "score"
        )
    }
}
