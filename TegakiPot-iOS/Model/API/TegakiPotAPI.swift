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
}
