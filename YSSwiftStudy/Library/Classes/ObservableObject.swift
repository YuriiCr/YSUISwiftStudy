//
//  YSObservableObject.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 16.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

// MARK: Global function for thred safety

func synchronized<T>(_ object: NSObject, block: () -> (T) ) -> T {
    objc_sync_enter(object)

    let result =  block()
    
    objc_sync_exit(object)

    return result
}

class ObservableObject: NSObject {
    
    // MARK: Public Properties
    
    var state: ModelState = .didUnload {
        didSet {
            self.notifyOfState(state: self.state)
        }
    }
    
    // MARK: Private Properties
    
    private var notify: Bool = true
    private var controllers = NSHashTable<ObservationController>.weakObjects()
    private var observers = NSHashTable<AnyObject>.weakObjects()
    
    // MARK: Public methods
    
    func notify(of state: ModelState) {
        synchronized(self) {
            self.controllers.allObjects.forEach { (controller) in
                controller.notify(of: state)
            }
        }
    }
    
    func addObserver(obsever: NSObject) {
        synchronized(self) {
             self.observers.add(obsever)
        }
    }
    
    func removeObserver(observer:NSObject) {
        synchronized(self) {
            self.observers.remove(observer)
        }
    }
    
    func isObserver(observer: NSObject) -> Bool {
        return synchronized(self, block: { () -> (Bool) in
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
    
    func performBlockWithNotification(_ block: () -> ()) {
        self.perform(block: block, notify: true)
    }
    
    func performBlockWithoutNotification(_ block: () -> ()) {
        self.perform(block: block, notify: false)
    }
    
   // MARK: Private methods
    
    func perform(block: () -> (), notify: Bool) {
        synchronized(self) {
            let postNotificstion = self.notify
            self.notify = notify
            block()
            self.notify = postNotificstion
        }
    }
    
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



// MARK: Extensions for Observer

extension ObservableObject {
    class ObservationController {
        typealias ObserverType = AnyObject
        typealias ActionType = (ObservableObject) -> ()
        
        private var observableObject: ObservableObject?
        private var observer: ObserverType?
        
        private var relation = [ModelState : ActionType]()
        
        func notify(of state: ModelState) {
            _ = self.relation[state]
            
        }
        
        subscript(state: ModelState) -> ActionType? {
            get {
                return self.relation[state]
            }
            
            set {
                self.relation[state] = newValue
            }
        }
    }
}


