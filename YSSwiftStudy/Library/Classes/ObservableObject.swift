//
//  YSObservableObject.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 16.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ObservableObject: NSObject {
    
    // MARK: Public Properties
    
    var state: ModelState = .didUnload {
        didSet { self.notifyOfState() }
    }
    
    // MARK: Private Properties
    
    private var notify: Bool = true
    private var controllers = NSHashTable<ObservationController>.weakObjects()
    
    // MARK: Public methods
    
    func notifyOfState() {
        synchronized(self) {
            self.controllers.allObjects.forEach {
                $0.notify(of: self.state)
            }
        }
    }
    
    func notifyWith(object: AnyObject?) {
        synchronized(self) {
            self.controllers.allObjects.forEach {
                $0.notify(of: self.state, object: object)
            }
        }
    }
    
    func controller(with observer: ObserverType) -> ObservationController {
        let controller = ObservationController(observableObject: self, observer: observer)
        self.controllers.add(controller)
        
        return controller
    }
    
    func remove(controller: ObservationController) {
        self.controllers.remove(controller)
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
            let postNotification = self.notify
            self.notify = notify
            block()
            self.notify = postNotification
        }
    }
}

// MARK: Extensions for Observer

extension ObservableObject {
    
    typealias ObserverType = AnyObject
    typealias ActionType = (ObservableObject, AnyObject?) -> ()
    
    class ObservationController {
        
        // MARK: Public properties
        
        private var observableObject: ObservableObject
        private var observer: ObserverType
        
        private var relation = [ModelState : ActionType]()
        
        // MARK: Initialization
        
        init(observableObject: ObservableObject, observer: ObserverType) {
            self.observableObject = observableObject
            self.observer = observer
        }
        
        // MARK: Public method
        
        func notify(of state: ModelState, object: AnyObject? = nil) {
            if let block = self.relation[state] {
                block(self.observableObject, object)
            }
        }
        
        // MARK: Subscript
        
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


