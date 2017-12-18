//
//  ResultEnum.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 11.12.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    
    func isSuccess() -> Bool {
        switch self {
        case .success: return true
        default: return false
        }
    }
    
    func isFailure() -> Bool {
        return !isSuccess()
    }
    
    func map<U>(block: (T) -> U) -> Result<U> {
        switch self {
        case .success(let value):
            return .success(block(value))
        case .failure(let error):
            return .failure(error)
        }
    }
}



