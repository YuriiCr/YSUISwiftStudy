//
//  FBViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBViewController: UIViewController {
    
    // MARK: Public properties
    
    var  observationController: ObservableObject.ObservationController? 
    
    var model: Model = Model() {
        didSet { self.observationController = self.model.controller(with: self) }
    }
    
    var currentUser = FBCurrentUser()
    
    var context: YSContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Initialization
    
    init() {
        super.init(nibName: toString(type: type(of: self)), bundle: .main)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
