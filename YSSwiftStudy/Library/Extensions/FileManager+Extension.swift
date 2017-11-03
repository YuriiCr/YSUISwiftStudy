//
//  FileManagerExtension.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 26.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

extension FileManager {
    static func pathWithNameFolder(_ nameFolder:String) -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        let folderPath = documentsPath.appending(documentsPath)
        if !FileManager.default.fileExists(atPath: folderPath) {
            do {
            try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print (error.localizedDescription)
            }
        }
        
        return folderPath
    }
    
    static func deleteFolderAtPath(_ path:String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try
                    FileManager.default.removeItem(atPath: path)
            } catch _ as NSError {
                return false
            }
            
            return true
        }
        
        return false
    }
}
