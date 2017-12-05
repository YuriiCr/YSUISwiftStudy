//
//  ImageView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 04.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ImageView: YSView {
   
    //MARK: Public properties
    
    var imageModel: ImageModel? {
        willSet {
            self.observationController = self.imageModel?.controller(with: self)
            newValue?.load()
        }
        
        didSet { self.observationController.map { oldValue?.remove(controller: $0) } }
    }
    
    var imageView: UIImageView? {
        willSet { newValue?.addSubview(self) }
        didSet { oldValue?.removeFromSuperview() }
    }
    
    var  observationController: ObservableObject.ObservationController? {
        willSet {
            let controller = self.observationController
            let loadingView = self.loadingView
            
            controller?[.didLoad] = { [weak self]
                _, _ in
                loadingView?.state = .hidden
                self?.fillWith(model: self?.imageModel)
            }
            
            controller?[.willLoad] = {
                _, _ in
                loadingView?.state = .visible
            }
            
            controller?[.loadingFailed] = {
                _, _ in
                loadingView?.state = .hidden
            }
        }
    }
    
    // MARK: Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView = UIImageView(frame: self.bounds)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame: self.bounds)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    func fillWith(model: ImageModel?) {
        self.imageView?.image = model?.image
    }

}
