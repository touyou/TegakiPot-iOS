//
//  QuestionStruct.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki

// MARK: - Questions
public struct Questions {
    public var questions: [Question]?
}

extension Questions: Decodable {
    public static func decode(_ e: Extractor) throws -> Questions {
        return try Questions(
            questions: decodeArray(e.rawValue)
        )
    }
}

// MARK: - Question
public struct Question {
    public var id: UInt64?
    public var postedBy: User?
    public var isSolved: Bool?
//    public var field: Field?
    public var tags: [String]?
    public var title: String?
    public var description: String?
    public var svg: String?
    public var ocr: String?
    public var good: Int?
    public var bad: Int?
    public var votes: Int?
    public var views: Int?
    public var answers: [Answer]?
    public var createdAt: Date?
    public var updatedAt: Date?
}

extension Question: Decodable {
    public static func decode(_ e: Extractor) throws -> Question {
        let transformer = TransformUtility()
        
        return try Question(
            id: e <|? "id",
            postedBy: e <|? "posted_by",
            isSolved: e <|? "is_solved",
//            field: e <|? "field",
            tags: e <||? "tags",
            title: e <|? "title",
            description: e <|? "description",
            svg: e <|? "svg",
            ocr: e <|? "ocr",
            good: e <|? "good",
            bad: e <|? "bad",
            votes: e <|? "votes",
            views: e <|? "views",
            answers: e <||? "answers",
            createdAt: transformer.applyDate(e <|? "created_at"),
            updatedAt: transformer.applyDate(e <|? "updated_at")
        )
    }
}
