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
        self.viewModel.didLogin.subscribe({ _ in
            self.showViewController()
            self.rootView?.loadingView?.state = .hidden
        }).disposed(by: self.disposeBag)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.loadingView?.state = .hidden
        self.rootView?.fill(with: self.viewModel)
    }
    
    // MARK: Public methods
    
    func showViewController() {
        let user = self.viewModel.model
        let navigationController = UINavigationController(rootViewController: FBUserViewController(model: user, currentUser: user))
        self.present(navigationController, animated: true, completion: nil)
    }

}
