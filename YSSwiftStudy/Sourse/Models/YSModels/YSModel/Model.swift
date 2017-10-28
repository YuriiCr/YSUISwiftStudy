//
//  Model.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 16.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

protocol ModelObserver {
    func modelDidUnload(_ model:Model)
    func modelWillLoad(_ model:Model)
    func modelDidLoad( _model:Model)
    func modelFailedLoading(_ model:Model)
}

enum ModelState {
    case modelDidUnload
    case modelWillLoad
    case modelDidLoad
    case modelFailedLoading
    case modelChanged
}

class Model: ObservableObject {
    
    // MARK: Public methods
    func load() {
        let state = self.state
        if (state == ModelState.modelWillLoad || state == ModelState.modelDidLoad) {
            self.notifyOfState(state: state)
            return;
        }
        self.state = ModelState.modelWillLoad
        self.performLoadingInBackground()
    }
    
    func performLoading() {
    
    }
    
    // MARK: Private methods
    
    private func performLoadingInBackground() {
        backgroundQueue.async {
            self.performLoading()
        }
    }
    
    // MARK: Model Observer
    
    override func selectorForState(state:ModelState) -> Selector? {
        switch state {
        case .modelDidUnload:
            return Selector(("modelDidUnload:"))
        case .modelWillLoad:
            return Selector(("modelWillLoad:"))
        case .modelDidLoad:
            return Selector (("modelDidLoad:"))
        case .modelFailedLoading:
            return Selector(("modelFailedLoading:"))
        
        default:
            return super.selectorForState(state: state)
        }
    }

}
