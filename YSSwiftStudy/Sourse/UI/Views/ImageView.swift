//
//  ImageView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 04.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ImageView: YSView, ModelObserver {
   
    

    //MARK: Public properties
    
    var imageModel: ImageModel? {
        willSet {
            if let model = newValue {
                model.addObserver(obsever: self)
                model.load()
            }
        }
        
        didSet {
            if let model = oldValue {
                model.removeObserver(observer: self)
            }
        }
    }
    
    var imageView: UIImageView? {
        willSet {
            if let imageView = newValue {
                self.addSubview(imageView)
            }
        }
        
        didSet {
            if let imageView = oldValue {
                imageView.removeFromSuperview()
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    func fillWith(model: ImageModel) {
        self.imageView?.image = model.image
    }
    
    // MARK: Model Observer
    
    func modelDidUnload(_ model: Model) {
        
    }
    
    func modelWillLoad(_ model: Model) {
        DispatchQueue.main.async {
            self.loadingView?.state = .visible
        }
    }
    
    func modelDidLoad(_ model: Model) {
        self.loadingView?.state = .hidden
        fillWith(model: model as! ImageModel)

    }
    
    func modelFailedLoading(_ model: Model) {
        
    }

}
