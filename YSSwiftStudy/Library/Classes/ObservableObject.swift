//
//  YSObservableObject.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 16.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

// MARK: Global function for thred safety

func synchronized<T>(object: NSObject, block: () -> (T) ) -> T {
    objc_sync_enter(object)

    let result =  block()
    
    objc_sync_exit(object)

    return result
}

class ObservableObject: NSObject {
    
    // MARK: Public Properties
    
    var state: ModelState = ModelState.modelDidUnload {
        willSet {
            self.notifyOfState(state: newValue)
        }
    }
    
    // MARK: Private Properties
    
    private var notify: Bool = true
    private var observers = NSHashTable<AnyObject>.weakObjects()
    
    // MARK: Public methods
    
    func addObserver(obsever: NSObject) {
        synchronized(object: self) {
             self.observers.add(obsever)
        }
    }
    
    func removeObserver(observer:NSObject) {
        synchronized(object: self) {
            self.observers.remove(observer)
        }
    }
    
    func isObserver(observer: NSObject) -> Bool {
        return synchronized(object: self, block: { () -> (Bool) in
            self.observers.contains(observer)
        })
    }
    
    func notifyOfState(state:ModelState) {
        self.notifyOfStateWithSelector(selector: self.selectorForState(state: state))
    }
    
    func notifyOfStateWithObject(state:ModelState, object:NSObject) {
        self.notifyOfStateWithSelectorWithObject(selector: self.selectorForState(state: state), obj: object)
    }
    
    func selectorForState(state:ModelState) -> Selector? {
        return nil
    }
    
   // MARK: Private methods
    
    private func notifyOfStateWithSelector(selector: Selector?) {
        if self.notify {
            self.observers.allObjects.forEach({ (object) in
                if (object.responds(to: selector)) {
                     _ = object.perform(selector, with: self)
                }
            })
        }
    }
    
    private func notifyOfStateWithSelectorWithObject(selector: Selector?, obj: NSObject) {
        if self.notify {
            self.observers.allObjects.forEach({ (object) in
                if (object.responds(to: selector)) {
                    _ = object.perform(selector, with: obj)
                }
            })
        }
    }
}
