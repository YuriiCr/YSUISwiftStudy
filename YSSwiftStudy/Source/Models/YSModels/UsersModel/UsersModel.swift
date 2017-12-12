//
//  UsersModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class UsersModel: ArrayModel<FBUser> {
    
    // MARK: Constants
    
    private struct Constants {
        static let pathComponent = "Users.plist"
        static let numberOfCells = 11
    }
    
    // MARK: Private properties
    
    private var pathList: String? {
         let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        return documentsPath?.appending(Constants.pathComponent)
        
    }
    
    private let notifiactionNames:[NSNotification.Name] = [.UIApplicationWillTerminate, .UIApplicationWillResignActive]
    
    // MARK: Initialization
    
    deinit { self.cancelNotification() }
    
    override init() {
        super.init()
        self.subscribeNotification()
    }
    
    // MARK: Public methods
    
    override func performLoading() {
        var objects:Array<FBUser>?
        
        if let path = self.pathList {
            objects = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? Array<FBUser>
            if objects == nil {
                objects = Array(repeatElement(FBUser(), count: Constants.numberOfCells))
            }
        }
        self.performBlockWithoutNotification { [weak self] in
            objects.map { self?.addObjects($0) }
        }
        self.state = .didLoad
    }
    
    func save() {
        if let path = self.pathList {
            NSKeyedArchiver.archiveRootObject(self.array , toFile: path)
        }
        
//        _ = self.pathList.map { NSKeyedArchiver.archiveRootObject(self.array , toFile: $0) }
    }
    
    // MARK: Private Methods
    
    func subscribeNotification() {
        for name in self.notifiactionNames {
            NotificationCenter.default.addObserver(forName: name, object: nil, queue: OperationQueue.main, using: {[weak self] (_) in
                self?.save()
            })
        }
    }
    
    func cancelNotification() {
        for name in self.notifiactionNames {
            NotificationCenter.default.removeObserver(self, name: name, object: nil)
        }
    }
    
}
