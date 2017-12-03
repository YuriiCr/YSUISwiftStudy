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
    
    var model:Model? = FBUser() {
        willSet {
            self.observationController = self.model?.controller(with: self)
        }
        
        didSet {
            if let controller = self.observationController {
                oldValue?.remove(controller: controller)
            }
        }
    }
    
    init(model: Model?, nibName: String, bundle: Bundle = .main) {
        super.init(nibName: nibName, bundle: bundle)
        self.model = model
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var context:YSContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }

    //MARK: Public Methods
    
    func fill(with model: Model?) {
        
    }
    
}
