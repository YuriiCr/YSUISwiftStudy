//
//  FBLoginViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class FBLoginViewController: UIViewController, RootView {
    
    // MARK: RootView
    
    typealias ViewType = FBLoginView
    
    // MARK: Public properties
    
    var viewModel: FBLoginViewModel
    
    // MARK: Private properties
    
    private var disposeBag = DisposeBag()
    
    // MARK: Initialization
    
    init(viewModel: FBLoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: toString(type: type(of: self)), bundle: .main)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.loadingView?.state = .hidden
        self.rootView?.fill(with: self.viewModel)
        self.prepareObserving()
    }
    
    // MARK: Private methods
    
    private func prepareObserving() {
        self.viewModel.didFinishAuthorization.subscribe({ [weak self] _ in
            self?.showViewController()
            self?.rootView?.loadingView?.state = .hidden
        }).disposed(by: self.disposeBag)
    }
    
    private func showViewController() {
        let user = self.viewModel.model
        let navigationController = UINavigationController(rootViewController: FBUserViewController(model: user, currentUser: user))
        self.present(navigationController, animated: true, completion: nil)

    }
    
}
