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
    
    // MARK: - Get
    
    struct GetQuestions: TegakiPotRequest {
        typealias Response = Questions
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/questions.json"
        }
    }
    
    struct GetQuestionDetail: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = Question
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/questions/\(id).json"
        }
    }
    
    struct GetAnswers: TegakiPotRequest {
        typealias Response = Answers
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/answers.json"
        }
    }
    
    struct GetAnswerDetail: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = Answer
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/questions/\(id).json"
        }
    }
    
    struct GetUserDetail: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = User
        
        var method: HTTPMethod {
            return .get
        }
        
        var path: String {
            return "/users/\(id).json"
        }
    }
    
    // MARK: - Post
    
    struct PostAuth: TegakiPotRequest {
        let email: String
        let password: String
        
        typealias Response = AuthResult
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/users/auth.json"
        }
        
        var parameters: Any? {
            return [
                "user": [
                    "email": email,
                    "password": password
                ]
            ]
        }
    }
    
    struct PostQuestion: TegakiPotRequest {
        let postedBy: UInt64
        let selectedField: Int
        let tags: [String]
        let title: String
        let description: String
        let svg: String
        let fieldsArray: Array<[String: String]> = [
            ["name": "Mathematics", "name_jp": "数学", "color": "#03a9f4"],
            ["name": "Computer Science", "name_jp": "情報科学", "color": "#3f51b5"],
            ["name": "Statistics", "name_jp": "統計学", "color": "#009688"],
            ["name": "Physics", "name_jp": "物理学", "color": "#ff9800"],
            ["name": "Biology", "name_jp": "生物学", "color": "#4caf50"],
            ["name": "Chemistry", "name_jp": "化学", "color": "#e91e63"],
            ["name": "Others", "name_jp": "その他", "color": "#607d8b"]
        ]
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/questions/new.json"
        }
        
        var parameters: Any? {
            return [
                "question": [
                    "posted_by": postedBy,
                    "field": fieldsArray[selectedField],
//                    "tags": tags,
                    "title": title,
                    "description": description,
                    "svg": [
                        "changeingThisBreaksApplicationSecurity": svg
                    ]
                ]
            ]
        }
    }
    
    struct PostAnswer: TegakiPotRequest {
        let postedBy: UInt64
        let questionId: UInt64
        let description: String
        let svg: String
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/answers/new.json"
        }
        
        var parameters: Any? {
            return [
                "answer": [
                    "posted_by": postedBy,
                    "question_id": questionId,
                    "description": description,
                    "svg":  [
                        "changeingThisBreaksApplicationSecurity": svg
                    ]
                ]
            ]
        }
    }
    
    struct PostQuestionGood: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/questions/update/good/\(id).json"
        }
    }
    
    struct PostQuestionBad: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/questions/update/bad/\(id).json"
        }
    }
    
    struct PostQuestionView: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/questions/update/view/\(id).json"
        }
    }
    
    struct PostAnswerGood: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/answers/update/good/\(id).json"
        }
    }
 
    struct PostAnswerBad: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/answers/update/bad/\(id).json"
        }
    }

    struct PostAnswerView: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/answers/update/view/\(id).json"
        }
    }

    struct PostUserView: TegakiPotRequest {
        let id: UInt64
        
        typealias Response = PostResponse
        
        var method: HTTPMethod {
            return .post
        }
        
        var path: String {
            return "/users/update/view/\(id).json"
        }
    }
}

// MARK: - Post Response
public struct PostResponse {}
extension PostResponse: Decodable {
    public static func decode(_ e: Extractor) throws -> PostResponse {
        return PostResponse()
    }
}

