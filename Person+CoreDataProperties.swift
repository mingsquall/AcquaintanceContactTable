//
//  Person+CoreDataProperties.swift
//  ContactTable
//
//  Created by Patientman on 2016/11/25.
//  Copyright © 2016年 mingSquall. All rights reserved.
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person");
    }

    @NSManaged public var name: String?
    @NSManaged public var image: NSData?
    @NSManaged public var notes: String?

}
