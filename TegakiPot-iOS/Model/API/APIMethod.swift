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
    
    
}
