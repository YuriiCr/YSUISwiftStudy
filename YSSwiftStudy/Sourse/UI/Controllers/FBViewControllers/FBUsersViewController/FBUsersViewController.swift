//
//  FBUsersViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBUsersViewController: FBViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Constants
    
    private struct Constants {
        static let title = "Friends"
    }
    
    // MARK: Public properties
    
    typealias ViewType = FBUserView
    var rootView: FBUsersView?
    
    var usersModel:UsersModel? {
        return (self.model as! UsersModel)
    }

    // MARK: Private properties
    
    private var logoutContext:FBLogoutContext? {
        willSet {
            newValue?.execute()
        }
        
        didSet {
            oldValue?.cancel()
        }
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let model = self.model {
             self.context = GetUsersContext(model: model)
        }
    }
    
    // MARK: IBAction
    
    @IBAction func logOut(sender: UIButton) {
        self.logoutContext = FBLogoutContext()
    }
    
    // MARK: Public methods
    
    override func fill(with model: Model) {
        self.navigationItem.title = Constants.title
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
        <#code#>
    }

    
}
