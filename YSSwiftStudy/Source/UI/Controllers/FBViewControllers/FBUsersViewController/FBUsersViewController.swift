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
        didSet {
            let controller = self.observationController
            let loadingView = self.rootView?.loadingView
            
            controller?[.didLoad] = { [weak self, weak loadingView] _, _ in
                self?.fill(with: self?.model)
                loadingView?.state = .hidden
            }
            
            controller?[.didUnload] = { [weak self] _, _ in
                self?.dismiss(animated: true)
            }
            
            controller?[.willLoad] = { [weak loadingView] _, _ in
                loadingView?.state = .visible
            }
            
            controller?[.loadingFailed] = { [weak loadingView] _, _ in
               loadingView?.state = .hidden
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
        self.model.map { self.context = GetUsersContext(model: $0, currentUser: FBCurrentUser()) }
        self.navigationItem.title = Constants.title
    }
    
    // MARK: IBAction
    
    @IBAction func logOut(sender: UIButton) {
        self.logoutContext = FBLogoutContext(model: self.model!)
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model?) {
        self.rootView?.tableView?.reloadData()
    }
    
     // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(with: FBTableViewCell.self, index: [indexPath.row])
        cell.user = self.usersModel?[indexPath.row]
       
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(FBUserViewController(model: self.usersModel?[indexPath.row], nibName: toString(type: FBUserViewController.self)), animated: true)
    }
}
