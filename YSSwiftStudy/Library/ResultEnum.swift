//
//  ResultEnum.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 11.12.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

enum Result<T> {
    case succes(value: T)
    case failure
}

