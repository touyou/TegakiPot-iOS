//
//  AnswerStruct.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki

// MARK: - Answer
public struct Answer {
    public var id: UInt64
    public var postedBy: User
    public var questionId: UInt64
    public var questionTitle: String
    public var description: String
    public var svg: String
    public var ocr: String
    public var good: Int
    public var bad: Int
    public var votes: Int
    public var views: Int
    public var createdAt: Date
    public var updatedAt: Date
    
}

extension Answer: Decodable {
    public static func decode(_ e: Extractor) throws -> Answer {
        let transformer = TransformUtility()
        
        return try Answer(
            id: e <| "id",
            postedBy: e <| "posted_by",
            questionId: e <| "question_id",
            questionTitle: e <| "question_title",
            description: e <| "question_title",
            svg: e <| "svg",
            ocr: e <| "ocr",
            good: e <| "good",
            bad: e <| "bad",
            votes: e <| "votes",
            views: e <| "views",
            createdAt: transformer.applyDate(e <| "created_at"),
            updatedAt: transformer.applyDate(e <| "updated_at")
        )
    }
}
