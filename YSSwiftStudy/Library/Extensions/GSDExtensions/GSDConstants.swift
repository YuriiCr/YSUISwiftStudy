//
//  YSGSDFunction.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 17.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//
import UIKit

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)

let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)

let utilityQueue = DispatchQueue.global(qos: .utility)

let backgroundQueue = DispatchQueue.global(qos: .background)

let defaultQueue = DispatchQueue.global()
