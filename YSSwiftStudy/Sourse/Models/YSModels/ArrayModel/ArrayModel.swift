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

class ArrayModel<T> : Model {
    
    // MARK: Public Properties
    
    private var array: Array<T> = []
    
    var count:Int {
       return self.array.count
    }
    
    // MARK: Public Methods
    
    func add(_ object: T) {
        synchronized(object: self) {
            self.insertObject(object, index: self.count)
        }
    }
    
    func addObjects(_ objects: T) {
        
    }
    
    func remove(_ object: T) {
        synchronized(object: self) {
            self.removeObjectAtIndex(self.indexOfObject(object))
        }
    }
    
    func removeObject (_ objects: T) {
        
    }
    
    func objectAtIndex(_ index: Int) -> Int? {
        return synchronized(object: self) {
            return self.count > index ? self.array[index] : nil
            } as? Int
    }
    
    func indexOfObject(_ object: T) -> Int {
        return synchronized(object: self, block: { () -> (Int) in
            return self.array.index(where: { (object) -> Bool in
                return true
            })!
        })
    }
    
    func insertObject(_ object: T, index: Int) {
        synchronized(object: self) {
            self.array.insert(object, at: index)
              let modelChange:ArrayModelChange = ArrayModelChangeInsert(index: index)
            self.notifyOfStateChangeWith(object: modelChange as! T)
        }
    }
    
    func removeObjectAtIndex(_ index: Int) {
        synchronized(object: self) {
            if self.count > index {
                self.array.remove(at: index)
                let modelChange:ArrayModelChange = ArrayModelChangeDelete(index: index)
                self.notifyOfStateChangeWith(object: modelChange as! T)
            }
        }
    }
    
    func moveObject(at index: Int, to destinationIndex:Int) {
        synchronized(object: self) {
            if index != destinationIndex {
                self.array.moveObject(at: index, to: destinationIndex)
                let modelChange:ArrayModelChange = ArrayModelChangeMove(index: index, destinationIndex: destinationIndex)
                self.notifyOfStateChangeWith(object: modelChange as! T)
            }
        }
    }
    
     // MARK: Private Methods
    
    func notifyOfStateChangeWith(object: T) {  self.notifyOfStateWithObject(state: .modelChanged, object: object as! NSObject)
    }
    
    // MARK: Observation
    
    override func selectorForState(state:ModelState) -> Selector? {
        switch state {
        case .modelChanged:
            return Selector(("arrayModelChangeWith:"))
        default:
            return super.selectorForState(state: state)
        }
    }
    
}
