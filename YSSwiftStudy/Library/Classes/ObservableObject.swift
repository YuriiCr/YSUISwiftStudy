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
        didSet {
            if notify { self.notifyOfState() }
        }
    }
    
    // MARK: Private Properties
    
    private var notify: Bool = true
    private var controllers = [ObservationController]()
    
    // MARK: Public methods
    
    func notifyOfState() {
        synchronized(self) {
            self.controllers.forEach {
                $0.notify(of: self.state)
            }
        }
    }
    
    func notifyWith(object: AnyObject?) {
        synchronized(self) {
            self.controllers.forEach {
                $0.notify(of: self.state, object: object)
            }
        }
    }
    
    func controller(with observer: ObserverType) -> ObservationController {
        let controller = ObservationController(observableObject: self, observer: observer)
        self.controllers.append(controller)
        
        return controller
    }
    
    func remove(controller: ObservationController) {
        self.controllers.remove(object: controller)
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
    
    class ObservationController: Hashable {
        
        // MARK: Public properties
        
        private weak var observableObject: ObservableObject?
        private weak var observer: ObserverType?
        
        private var relation = [ModelState : ActionType]()
        
        // MARK: Initialization
        
        init(observableObject: ObservableObject, observer: ObserverType) {
            self.observableObject = observableObject
            self.observer = observer
            self.hashValue = observableObject.hashValue
        }
        
        // MARK: Public method
        
        func notify(of state: ModelState, object: AnyObject? = nil) {
            if let block = self.relation[state], let observableObject = self.observableObject {
                block(observableObject, object)
            }
        }
        
        // Hashable
        
        static func ==(lhs: ObservableObject.ObservationController, rhs: ObservableObject.ObservationController) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
        
        public var hashValue = 0
        
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


