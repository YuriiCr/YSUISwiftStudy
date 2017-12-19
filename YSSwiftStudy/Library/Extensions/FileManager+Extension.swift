//
//  FileManagerExtension.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 26.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import Foundation

extension FileManager {
    static func pathWithNameFolder(_ nameFolder:String) -> String? {
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        let folderPath = documentsPath?.appending(nameFolder)
        if let folderPath = folderPath {
            if !FileManager.default.fileExists(atPath: folderPath) {
                try? FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: false, attributes: nil)
            }
        }
        
        return folderPath
    }
    
    static func deleteFolderAtPath(_ path:String) -> Bool {
        if FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.removeItem(atPath: path)
                return true
            } catch _ as NSError {
                return false
            }
        }
        
        return false
    }
}
