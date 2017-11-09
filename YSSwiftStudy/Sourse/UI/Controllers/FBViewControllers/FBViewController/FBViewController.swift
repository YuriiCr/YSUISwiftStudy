//
//  FBViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBViewController: UIViewController, RootView {
    
    // MARK: Public properties
    typealias ViewType = YSView
    var rootView: YSView?
    
    var model:Model? {
        willSet {
            
        }
        
        didSet {
            
        }
    }
    
    var context:YSContext? {
        willSet {
            newValue?.execute()
        }
        
        didSet {
            oldValue?.cancel()
        }
    }

    //MARK: Public Methods
    
    func fill(with model: Model) {
        
    }

}
