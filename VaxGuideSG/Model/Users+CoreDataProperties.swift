//
//  Users+CoreDataProperties.swift
//  
//
//  Created by owrmac on 28/7/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var email: String?
    @NSManaged public var fullname: String?
    @NSManaged public var nric: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?

}
