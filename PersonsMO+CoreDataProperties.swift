//
//  PersonsMO+CoreDataProperties.swift
//  ContactTable
//
//  Created by Patientman on 2016/11/25.
//  Copyright © 2016年 mingSquall. All rights reserved.
//

import Foundation
import CoreData


extension PersonsMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonsMO> {
        return NSFetchRequest<PersonsMO>(entityName: "Person");
    }

    @NSManaged public var name: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var notes: String?
    
    // MARK: Core Date Paths
    
    static let ApplicationSupportDirectory = FileManager().urls(for: .applicationDirectory, in: .userDomainMask).first!
    static let StoreURL = ApplicationSupportDirectory.appendingPathComponent("Acquaintance.sqlite")
    
}
