//
//  DUser+CoreDataProperties.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 26.12.2017.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//
//

import Foundation
import CoreData


extension DUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DUser> {
        return NSFetchRequest<DUser>(entityName: "DUser")
    }

    @NSManaged public var photoUrl: URL?
    @NSManaged public var name: String?
    @NSManaged public var surname: String?

}
