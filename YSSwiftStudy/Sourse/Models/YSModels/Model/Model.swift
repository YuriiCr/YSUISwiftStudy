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
    func modelDidLoad(_ model:Model)
    func modelFailedLoading(_ model:Model)
}

enum ModelState {
    case didUnload
    case willLoad
    case didLoad
    case loadingFailed
    case changed
}

class Model: ObservableObject {
    
    // MARK: Public methods
    
    func load() {
        let state = self.state
        if (state == .willLoad || state == .didLoad) {
            self.notifyOfState(state: state)
            return;
        }
        self.state = .willLoad
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
    
    override func selectorForState(state: ModelState) -> Selector? {
        switch state {
        case .didUnload:
            return Selector(("modelDidUnload:"))
        case .willLoad:
            return Selector(("modelWillLoad:"))
        case .didLoad:
            return Selector (("modelDidLoad:"))
        case .loadingFailed:
            return Selector(("modelFailedLoading:"))
        
        default:
            return super.selectorForState(state: state)
        }
    }

}
