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
            self.notify(of: self.state)
        }
    }
    
    // MARK: Private Properties
    
    private var notify: Bool = true
    private var controllers = NSHashTable<ObservationController>.weakObjects()
    
    // MARK: Public methods
    
    func notify(of state: ModelState) {
        synchronized(self) {
            self.controllers.allObjects.forEach { (controller) in
                controller.notify(of: state)
            }
        }
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
            if let block = self.relation[state], let object = self.observableObject {
                block(object)
            }
            
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


