//
//  FBUsersViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUsersViewController: FBViewController, RootView {
    
    // MARK: Constants
    
    private struct Constants {
        static let title = "Friends"
    }
    
    // MARK: Public properties
    
    typealias ViewType = FBUserView
    
    var rootView: FBUsersView?
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let controller = self.observationController
            let loadingView = self.rootView?.loadingView

            controller?[.didLoad] = { [weak self, weak loadingView] _, _ in
                self?.rootView?.tableView?.reloadData()
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
    
    private var user = FBUser()
    
    var usersModel: UsersModel? { return self.model as? UsersModel }
    
    private var logoutContext:FBLogoutContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Initialization
    
    init(model: Model, user: FBUser, currentUser: FBCurrentUser ) {
        super.init()
        self.model = model
        self.user = user
        self.currentUser = currentUser
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rootView?.loadingView?.state = .hidden
        self.context = GetUsersContext(model: self.model, user: self.user, currentUser: self.currentUser)
        self.navigationItem.title = Constants.title
    }
    
    // MARK: IBAction
    
    @IBAction func onlogOut(sender: UIButton) {
          (self.model as? FBCurrentUser).map { self.logoutContext = FBLogoutContext(user: $0) }
    }
}

extension FBUsersViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        self.usersModel?[indexPath.row].map { self.navigationController?.pushViewController(FBUserViewController(model: $0, currentUser: self.currentUser), animated: true) }
    }
}
