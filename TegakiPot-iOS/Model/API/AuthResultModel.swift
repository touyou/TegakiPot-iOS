//
//  AuthResultModel.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki

// MARK: - UserList
public struct UserList {
    public var id: UInt64?
    public var userName: String?
}

extension UserList: Decodable {
    public static func decode(_ e: Extractor) throws -> UserList {
        return try UserList(
            id: e <|? "id",
            userName: e <|? "username"
        )
    }
}

// MARK: - QuestionList
public struct QuestionList {
    public var id: UInt64?
    public var title: String?
    public var field: Field?
    public var votes: Int?
    public var updatedAt: Date?
}

extension QuestionList: Decodable {
    public static func decode(_ e: Extractor) throws -> QuestionList {
        let transformer = TransformUtility()
        
        return try QuestionList(
            id: e <|? "id",
            title: e <|? "title",
            field: e <|? "field",
            votes: e <|? "votes",
            updatedAt: transformer.applyDate(e <|? "updated_at")
        )
    }
}

// MARK: - AnswerList
public struct AnswerList {
    public var id: UInt64?
    public var questionId: UInt64?
    public var questionTitle: String?
    public var votes: Int?
    public var updatedAt: Date?
}

extension AnswerList: Decodable {
    public static func decode(_ e: Extractor) throws -> AnswerList {
        let transformer = TransformUtility()
        
        return try AnswerList(
            id: e <|? "id",
            questionId: e <|? "question_id",
            questionTitle: e <|? "question_title",
            votes: e <|? "votes",
            updatedAt: transformer.applyDate(e <|? "updated_at")
        )
    }
}


// MARK: - AuthResult
public struct AuthResult {
    public var id: UInt64?
//    public var email: String?
//    public var passWord: String?
//    public var userName: String?
//    public var selfIntroduction: String?
//    public var posted: Int?
//    public var solved: Int?
//    public var rating: Int?
//    public var views: Int?
//    public var friends: [UserList]?
//    public var contributions: [Contribution]?
//    public var questions: [QuestionList]?
//    public var answers: [AnswerList]?
//    public var isValid: Bool?
//    public var createdAt: Date?
//    public var updatedAt: Date?
}

extension AuthResult: Decodable {
    public static func decode(_ e: Extractor) throws -> AuthResult {
        let transformer = TransformUtility()
        
        return try AuthResult(
            id: e <|? "id"
//            email: e <|? "email",
//            passWord: e <|? "password",
//            userName: e <|? "username",
//            selfIntroduction: e <|? "self_introduction",
//            posted: e <|? "posted",
//            solved: e <|? "solved",
//            rating: e <|? "rating",
//            views: e <|? "views",
//            friends: e <||? "friends",
//            contributions: e <||? "contributions",
//            questions: e <||? "questions",
//            answers: e <||? "answers",
//            isValid: e <|? "is_valid",
//            createdAt: transformer.applyDate(e <|? "created_at"),
//            updatedAt: transformer.applyDate(e <|? "updated_at")
        )
    }
}
