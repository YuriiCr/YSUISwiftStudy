//
//  FBLogoutContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBLogoutContext: FBLoginContext {
    
    // Public methods
    
    override func performEcexution(_ block: (ModelState) -> ()) {
        
        self.user?.token = nil
        block(.modelDidUnload)
    }

}
