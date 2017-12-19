//
//  Model.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 16.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

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
            self.state = state
            return
        }
        self.state = .willLoad
        self.performLoadingInBackground()
    }
    
    func performLoading() {
    
    }
    
    // MARK: Private methods
    
    private func performLoadingInBackground() {
        backgroundQueue.async {[weak self] in self?.performLoading() }
    }

}
