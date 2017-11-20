//
//  FBLogoutContext.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import FacebookLogin

class FBLogoutContext: FBLoginContext {
    
    // Public methods
    
    override func performExecution(_ block: @escaping (ModelState) -> ()) {
        LoginManager().logOut()
        self.user?.token = nil
        block(.didUnload)
    }

}
