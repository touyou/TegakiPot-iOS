//
//  TransformUtility.swift
//  TegakiPot-iOS
//
//  Created by 藤井陽介 on 2017/02/04.
//  Copyright © 2017年 touyou. All rights reserved.
//

import Foundation
import Himotoki

struct TransformUtility {
    
    let URLTransformer = Transformer<String, URL> { URLString throws -> URL in
        guard let URL = NSURL(string: URLString) else {
            throw customError("Invalid URL string: \(URLString)")
        }
        
        return URL as URL
    }
    
    func applyURL(_ string: String) throws -> URL {
        return try URLTransformer.apply(string)
    }
    
    let DateTransformer = Transformer<String, Date> { DateString throws -> Date in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let Date = formatter.date(from: DateString) else {
            throw customError("Invalid Date string: \(DateString)")
        }
        
        return Date
    }
    
    func applyDate(_ string: String) throws -> Date {
        return try DateTransformer.apply(string)
    }
    
}
