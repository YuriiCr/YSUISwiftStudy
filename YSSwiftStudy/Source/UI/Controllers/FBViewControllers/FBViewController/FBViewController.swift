//
//  FBViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBViewController: UIViewController {
    var  observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didLoad] = {
                model in
                self.fill(with: model)
                
                } as? ObservableObject.ObservationController.ActionType
            
            
        }
        
    }
    var model:Model? = FBUser()
    
    init(model: Model?) {
        super.init(nibName: nil, bundle: .main)
        self.model = model
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var context:YSContext? {
        willSet { newValue?.execute() }
        
        didSet { oldValue?.cancel() }
    }

    //MARK: Public Methods
    
    func fill(with model: Model) {
        
    }
    
    

}
