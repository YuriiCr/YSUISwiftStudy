//
//  YSView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 04.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class YSView: UIView {

    //MARK: Public properties
    
    @IBOutlet var loadingView:LoadingView? {
        willSet { newValue.map { self.addSubview($0) } }
        didSet { oldValue.map { $0.removeFromSuperview() } }
    }
    
    // MARK: Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.loadingView = LoadingView.loadingViewInView(view: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadingView = LoadingView.loadingViewInView(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
