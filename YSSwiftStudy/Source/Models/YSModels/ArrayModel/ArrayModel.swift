//
//  ArrayModel.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 27.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

protocol ArrayModelObserver {
    func arrayModelChangeWith(changeModel: ArrayModelChange)
}

class ArrayModel<Element: Equatable> : Model {
    
    // MARK: Public Properties
    
    var array: Array<Element> = []
    
    var count: Int {
       return self.array.count
    }
    
    // MARK: Public Methods
    
    func add(_ object: Element) {
        synchronized(self) {
            self.insertObject(object, index: self.count)
        }
    }
    
    func addObjects(_ objects: Array<Element>) {
        objects.forEach {
            self.add($0)
        }
    }
    
    func remove(object: Element) {
        synchronized(self) {
            if let index = self.array.index(of: object) {
                self.removeObject(at: index)
            }
        }
    }
    
    func remove(objects: Array<Element>) {
        objects.forEach {
            self.remove(object: $0)
        }
    }
    
    func objectAtIndex(_ index: Int) -> Element? {
        return synchronized(self) {
            return self.count > index ? self.array[index] : nil
            }
    }
    
    func insertObject(_ object: Element, index: Int) {
        synchronized(self) {
            self.array.insert(object, at: index)
              let modelChange:ArrayModelChange = ArrayModelChangeInsert(index: index)
            self.notifyOfStateChangeWith(object: modelChange)
        }
    }
    
    func removeObject(at index: Int) {
        synchronized(self) {
            if self.count > index {
                self.array.remove(at: index)
                let modelChange:ArrayModelChange = ArrayModelChangeDelete(index: index)
                self.notifyOfStateChangeWith(object: modelChange)
            }
        }
    }
    
    func moveObject(at index: Int, to destinationIndex:Int) {
        synchronized(self) {
            if index != destinationIndex {
                self.array.moveObject(at: index, to: destinationIndex)
                let modelChange:ArrayModelChange = ArrayModelChangeMove(index: index, destinationIndex: destinationIndex)
                self.notifyOfStateChangeWith(object: modelChange)
            }
        }
    }
    
    subscript(_ index: Int) -> Element? {
        get {
            return self.objectAtIndex(index)
        }
    }
    
     // MARK: Private Methods
    
    private func notifyOfStateChangeWith(object: ArrayModelChange) {
        self.notifyWith(object: object as AnyObject)
    }
    
}
