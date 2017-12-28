//
//  FBUserViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 08.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit
import CoreData

class FBUserViewController: FBViewController, RootView {
    
    // MARK: RootView
    
    typealias ViewType = FBUserView
    
    // MARK: Public properties
    
    override var observationController: ObservableObject.ObservationController? {
        didSet {
            let controller = self.observationController
            let loadingView = self.rootView?.loadingView
            
            controller?[.didLoad] = { [weak self, loadingView] _, _ in
                loadingView?.state = .hidden
                self?.rootView?.fillWith(user: self?.user)
            }
            
            controller?[.didUnload] = { [weak self] _, _ in
                self?.dismiss(animated: true)
            }
            
            controller?[.willLoad] = {[weak loadingView]  _, _ in
                loadingView?.state = .visible
            }
            
            controller?[.loadingFailed] = { _, _ in
                loadingView?.state = .hidden
            }
        }
    }
    
    var user: FBUser? { return self.model as? FBUser }
    
     var container: NSPersistentContainer? = (UIApplication.shared.delegate as? YSAppDelegate)?.persistentContainer
    
    // MARK: Private properties
    
    private var logoutContext:FBLogoutContext? {
        willSet { newValue?.execute() }
        didSet { oldValue?.cancel() }
    }
    
    // MARK: Initialization
    
    init(model: Model, currentUser: FBCurrentUser) {
        super.init()
        self.model = model
        self.currentUser = currentUser
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.context = GetUserContext(model: self.model, currentUser: self.currentUser)
        (self.model as? FBCurrentUser).map {
            self.rootView?.observeLogOutButton(with: $0)
        }
        self.rootView?.loadingView?.state = .hidden
        self.updateCoreData(with: self.currentUser)
    }
    
    // MARK: IBAction
    
    @IBAction func onFriends(sender: UIButton) {
        guard let user = self.user else { return }
        let usersController = FBUsersViewController(model: UsersModel(), user: user, currentUser: self.currentUser)
        self.navigationController?.pushViewController(usersController, animated: true)
    }
    
    // MARK: Private methods
    
    private func updateCoreData(with user: FBCurrentUser) {
        container?.performBackgroundTask({[weak self] (context) in
            DUser.createOrFind(user: user, in: context)
            self?.printDataBaseStatistics()

        })
        
    }
    
    private func printDataBaseStatistics() {
        if let context = container?.viewContext {
            context.perform {
                let request: NSFetchRequest<DUser> = DUser.fetchRequest()
                if let usersCount = (try? context.fetch(request))?.count {
                    print ("users count: ",usersCount)
                }
            }
        }
    }
}
