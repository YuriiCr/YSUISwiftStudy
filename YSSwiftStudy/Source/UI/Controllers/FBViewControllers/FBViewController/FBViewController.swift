//
//  FBViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBViewController: UIViewController, RootView {
    
    // MARK: RootView
    
    typealias ViewType = YSView
    
    // MARK: Public properties
    
    var  observationController: ObservableObject.ObservationController? {
        didSet {
            self.observationController?[.didLoad] = { [weak self]
                model in
                self?.fill(with: model as? Model)
                self?.rootView?.loadingView?.state = .hidden
                }
            
            self.observationController?[.didUnload] = { [weak self]
                model in
                self?.dismiss(animated: true)
            }
            
            self.observationController?[.willLoad] = { [weak self]
                model in
                self?.rootView?.loadingView?.state = .visible
            }
            
            self.observationController?[.loadingFailed] = { [weak self]
                model in
                self?.rootView?.loadingView?.state = .hidden
            }
        }
        
    }
    var model:Model? = FBUser() {
        didSet {
            self.observationController = self.model?.controller(with: self)
        }
    }
    
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
    
    func fill(with model: Model?) {
        
    }
    
    

}
