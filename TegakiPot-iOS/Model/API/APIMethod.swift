//
//  APIMethod.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import APIKit
import Himotoki
import Result

extension TegakiPotAPI {
    // MARK: - Get
    
    func getQuestions(success: @escaping ([Question])->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = GetQuestions()
        
        Session.send(request) { result in
            switch result {
            case .success(let questions):
                success(questions.questions ?? [])
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func getQuestionDetail(_ id: UInt64,
                           success: @escaping (Question)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = GetQuestionDetail(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let question):
                success(question)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func getAnswers(success: @escaping ([Answer])->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = GetAnswers()
        
        Session.send(request) { result in
            switch result {
            case .success(let answers):
                success(answers.answers ?? [])
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func getAnswerDetail(_ id: UInt64,
                         success: @escaping (Answer)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = GetAnswerDetail(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let answer):
                success(answer)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func getUserDetail(_ id: UInt64,
                       success: @escaping (User)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = GetUserDetail(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let user):
                success(user)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    // MARK: - Post
    
    func postAuth(email: String, password: String,
                  success: @escaping (AuthResult)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostAuth(email: email, password: password)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postQuestion(postedBy: String, selectedField: Int, tags: [String], title: String, description: String, svg: String,
                      success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostQuestion(postedBy: postedBy, selectedField: selectedField,
                                   tags: tags, title: title, description: description, svg: svg)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswer(postedBy: String, questionId: UInt64, description: String, svg: String,
                    success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostAnswer(postedBy: postedBy, questionId: questionId, description: description, svg: svg)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postQuestionGood(_ id: UInt64,
                          success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostQuestionGood(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postQuestionBad(_ id: UInt64,
                         success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostQuestionBad(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postQuestionView(_ id: UInt64,
                         success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostQuestionView(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswerGood(_ id: UInt64,
                          success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostAnswerGood(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswerBad(_ id: UInt64,
                        success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostAnswerBad(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswerView(_ id: UInt64,
                       success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostAnswerView(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postUserView(_ id: UInt64,
                        success: @escaping (PostResponse)->Void, failure: ((SessionTaskError) -> Void)? = nil) {
        let request = PostUserView(id: id)
        
        Session.send(request) { result in
            switch result {
            case .success(let result):
                success(result)
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
}
