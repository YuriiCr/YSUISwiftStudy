//
//  UsersModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class UsersModel: ArrayModel<ObservableObject> {
    
    // MARK: Constants
    
    private struct Constants {
        static let pathComponent:String = "Users.plist"
        static let numberOfCells:Int = 11
    }
    
    // MARK: Private properties
    
    private var pathList: String? {
         let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        let pathList = documentsPath?.appending(Constants.pathComponent)
        
        return pathList
        
    }
    
    // MARK: Public methods
    
    override func performLoading() {
        sleep(3)
        var objects:Array<User>?
        
        if let path = self.pathList {
            objects = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? Array<User>
            if objects == nil {
                objects = Array(repeatElement(User(), count: Constants.numberOfCells))
            }
        }
        self.performBlockWithoutNotification({
            if let objects = objects {
                 self.addObjects(objects)
            }
        })
        
    }
    
    func save() {
        if let path = self.pathList {
            NSKeyedArchiver.archiveRootObject(self.array , toFile: path)
        }
    }
    
}
