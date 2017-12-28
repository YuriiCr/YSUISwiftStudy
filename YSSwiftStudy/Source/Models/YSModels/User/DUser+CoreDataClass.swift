//
//  DUser+CoreDataClass.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 26.12.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//
//

import Foundation
import CoreData


public class DUser: NSManagedObject {
    
    class func createOrFind(user: FBCurrentUser, in context: NSManagedObjectContext) {
        let request: NSFetchRequest<DUser> = DUser.fetchRequest()
        if let url = user.photoURL {
            request.predicate = NSPredicate(format: "photoUrl = %@", url as CVarArg)
        }

        let result = try? context.fetch(request)
        if let result = result {
            if result.count > 0 {
                return
            }
        }
        
        let fbUser = DUser(context: context)
        fbUser.name = user.name
        fbUser.surname = user.surname
        fbUser.photoUrl = user.photoURL
        
        try? context.save()
    }

}
