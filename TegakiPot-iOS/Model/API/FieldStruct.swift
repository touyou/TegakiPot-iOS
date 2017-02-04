//
//  FieldStruct.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki

// MARK: - Field
public struct Field {
    public var name: String
    public var nameJp: String
    public var color: String
}

extension Field: Decodable {
    public static func decode(_ e: Extractor) throws -> Field {
        return try Field(
            name: e <| "name",
            nameJp: e <| "name_jp",
            color: "e <| color"
        )
    }
}
