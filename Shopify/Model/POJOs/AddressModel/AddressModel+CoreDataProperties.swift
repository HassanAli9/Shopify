//
//  AddressModel+CoreDataProperties.swift
//  
//
//  Created by Nasr on 24/03/2022.
//
//

import Foundation
import CoreData


extension AddressModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AddressModel> {
        return NSFetchRequest<AddressModel>(entityName: "AddressModel")
    }

    @NSManaged public var addID: Int64
    @NSManaged public var custID: Int64
    @NSManaged public var address1: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var customerName: String?
    @NSManaged public var phoneNumber: String?
}
