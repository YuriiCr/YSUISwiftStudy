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
//           newValue?.addObserver(obsever: self)
           newValue?.load()
        }
        
        didSet {
//            oldValue?.removeObserver(observer: self)
        }
    }
    
    var imageView: UIImageView? {
        willSet { newValue?.addSubview(self) }
        
        didSet { oldValue?.removeFromSuperview() }
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private methods
    
    func fillWith(model: ImageModel) {
        self.imageView?.image = model.image
    }

}
