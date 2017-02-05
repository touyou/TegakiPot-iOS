//
//  APIMethod.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Alamofire
import APIKit
import Himotoki
import Result

extension TegakiPotAPI {
    // MARK: - Get
    
    func getQuestions(success: @escaping ([Question])->Void, failure: ((Error) -> Void)? = nil) {
        let request = GetQuestions()
        
        Alamofire.request(request.path, method: request.method).responseJSON {
            response in
            switch response.result {
            case .success(_):
                if let jsonArray = response.result.value as? [Any] {
                    let jsonObject = jsonArray.map {
                        $0 as! [String: Any]
                    }
                    do {
                        let q = try Questions.decodeValue(jsonObject)
                        success(q.questions ?? [])
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func getQuestionDetail(_ id: UInt64,
                           success: @escaping (Question)->Void, failure: ((Error) -> Void)? = nil) {
        let request = GetQuestionDetail(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(Question.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func getAnswers(success: @escaping ([Answer])->Void, failure: ((Error) -> Void)? = nil) {
        let request = GetAnswers()
        
        Alamofire.request(request.path, method: request.method).responseJSON {
            response in
            switch response.result {
            case .success(_):
                if let jsonArray = response.result.value as? [Any] {
                    let jsonObject = jsonArray.map {
                        $0 as! [String: Any]
                    }
                    do {
                        let q = try Answers.decodeValue(jsonObject)
                        success(q.answers ?? [])
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }

    }
    
    func getAnswerDetail(_ id: UInt64,
                         success: @escaping (Answer)->Void, failure: ((Error) -> Void)? = nil) {
        let request = GetAnswerDetail(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(Answer.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func getUserDetail(_ id: UInt64,
                       success: @escaping (User)->Void, failure: ((Error) -> Void)? = nil) {
        let request = GetUserDetail(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(User.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }    }
    
    // MARK: - Post
    
    func postAuth(email: String, password: String,
                  success: @escaping (AuthResult)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostAuth(email: email, password: password)
        
        Alamofire.request(request.path, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    print(jsonObject)
                    do {
                        try success(AuthResult.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }

    func postQuestion(postedBy: UInt64, selectedField: Int, tags: [String], title: String, description: String, svg: String,
                      success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostQuestion(postedBy: postedBy, selectedField: selectedField,
                                   tags: tags, title: title, description: description, svg: svg)
        
        Alamofire.request(request.path, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswer(postedBy: UInt64, questionId: UInt64, description: String, svg: String,
                    success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostAnswer(postedBy: postedBy, questionId: questionId, description: description, svg: svg)
        
        Alamofire.request(request.path, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postQuestionGood(_ id: UInt64,
                          success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostQuestionGood(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }

    func postQuestionBad(_ id: UInt64,
                         success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostQuestionBad(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postQuestionView(_ id: UInt64,
                         success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostQuestionView(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswerGood(_ id: UInt64,
                          success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostAnswerGood(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswerBad(_ id: UInt64,
                        success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostAnswerBad(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postAnswerView(_ id: UInt64,
                       success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostAnswerView(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
    
    func postUserView(_ id: UInt64,
                        success: @escaping (PostResponse)->Void, failure: ((Error) -> Void)? = nil) {
        let request = PostUserView(id: id)
        
        Alamofire.request(request.path, method: request.method).responseJSON { response in
            switch response.result {
            case .success(_):
                if let jsonObject = response.result.value as? [String: Any] {
                    do {
                        try success(PostResponse.decodeValue(jsonObject))
                    } catch {
                        print("Parse Error")
                    }
                }
            case .failure(let error):
                failure?(error)
                print("error: \(TegakiPotError(statusCode: error._code).message)")
            }
        }
    }
}
