//
//  User.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki

// MARK: - User
public struct User {
    public var id: UInt64?
    public var email: String?
//    public var passWord: String?
    public var userName: String?
    public var selfIntroduction: String?
    public var posted: Int?
    public var solved: Int?
    public var rating: Int?
    public var views: Int?
    public var friends: [User]?
    public var contributions: [Contribution]?
    public var questions: Questions?
    public var answers: [Answer]?
    public var isValid: Bool?
    public var createdAt: Date?
    public var updatedAt: Date?
    
}

extension User: Decodable {
    public static func decode(_ e: Extractor) throws -> User {
        let transformer = TransformUtility()
        
        return try User(
            id: e <|? "id",
            email: e <|? "email",
//            passWord: e <|? "password",
            userName: e <|? "username",
            selfIntroduction: e <|? "self_introduction",
            posted: e <|? "posted",
            solved: e <|? "solved",
            rating: e <|? "rating",
            views: e <|? "views",
            friends: e <||? "friends",
            contributions: e <||? "contributions",
            questions: e <|? "questions",
            answers: e <||? "answers",
            isValid: e <|? "is_valid",
            createdAt: transformer.applyDate(e <|? "created_at"),
            updatedAt: transformer.applyDate(e <|? "updated_at")
        )
    }
}
