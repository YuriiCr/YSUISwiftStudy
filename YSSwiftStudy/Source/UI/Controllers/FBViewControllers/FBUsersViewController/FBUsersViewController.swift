//
//  FBUsersViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUsersViewController: FBViewController, RootView, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Constants
    
    private struct Constants {
        static let title = "Friends"
    }
    
    // MARK: Public properties
    
    typealias ViewType = FBUserView
    
    var rootView: FBUsersView?
    
    var usersModel:UsersModel? {
        return (self.model as? UsersModel)
    }
    
    // MARK: Public properties
    
    override var observationController: ObservableObject.ObservationController? {
        willSet {
            self.observationController?[.didLoad] = { [weak self]
                _, _ in
                self?.fill(with: self?.model)
                self?.rootView?.loadingView?.state = .hidden
            }
            
            self.observationController?[.didUnload] = { [weak self]
                _, _ in
                self?.dismiss(animated: true)
            }
            
            self.observationController?[.willLoad] = { [weak self]
                _, _ in
                self?.rootView?.loadingView?.state = .visible
            }
            
            self.observationController?[.loadingFailed] = { [weak self]
                _, _ in
                self?.rootView?.loadingView?.state = .hidden
            }
        }
    }

    // MARK: Private properties
    
    private var logoutContext:FBLogoutContext? {
        willSet { newValue?.execute() }
        
        didSet { oldValue?.cancel() }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let model = self.model {
             self.context = GetUsersContext(model: model)
        }
        self.navigationItem.title = Constants.title
    }
    
    // MARK: IBAction
    
    @IBAction func logOut(sender: UIButton) {
        self.logoutContext = FBLogoutContext()
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model?) {

        self.rootView?.tableView?.reloadData()
    }
    
     // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.usersModel {
            return model.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: FBTableViewCell.self, index: [indexPath.row])
        cell.user = self.usersModel?[indexPath.row] as? FBUser
       
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(FBUserViewController(model: self.usersModel?[indexPath.row] as? Model), animated: true)
    }
}
