//
//  LoadingView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 03.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    enum LoadingViewState {
        case hidden
        case visible
    }
    
    private struct Constants {
        static let loadingViewDuratuion = 0.2
        static let presentantionLoadingViewAlpha:CGFloat = 1
        static let loadingViewDefaultAlpha:CGFloat = 0.6
        static let loadingViewHiddenAlpha:CGFloat = 0
    }
    
    // MARK: Public properties
    
    @IBOutlet var indicator: UIActivityIndicatorView? {
        willSet {
            if let indicator = newValue {
                self.addSubview(indicator)
            }
        }
        
        didSet { oldValue?.removeFromSuperview()}
        
    }
    
    var state:LoadingViewState? {
        willSet {
            if let state = newValue {
                self.setStateWith(state)
            }
        }
    }
    
    // MARK: Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Pulic methods
    
    static func loadingViewInView (view: UIView) -> LoadingView {
        return LoadingView(frame: view.bounds)
    }
    
    func setStateWith(_ state: LoadingViewState, animated: Bool = true, handler: (() -> ())? = nil) {
        UIView.animate(withDuration: animated ? Constants.loadingViewDuratuion : 0,
                       animations: { [weak self] in
                        self?.alpha = state == .visible ? Constants.presentantionLoadingViewAlpha : Constants.loadingViewHiddenAlpha
        }) {[weak self] (_) in
            handler?()
            self?.state = state
        }
    }
    
    // MARK: Private methods
    
    private func initSubviews() {
        let bounds = self.bounds
        self.alpha = Constants.loadingViewDefaultAlpha
        self.indicator = UIActivityIndicatorView.init(activityIndicatorStyle:.whiteLarge)
        self.indicator?.center = CGPoint(x: bounds.midX, y: bounds.midY);
        
        self.indicator?.startAnimating()
        self.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleWidth, .flexibleHeight]
    }

}
