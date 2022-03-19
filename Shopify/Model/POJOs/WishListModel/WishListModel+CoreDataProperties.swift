//
//  WishListModel+CoreDataProperties.swift
//  
//
//  Created by Nasr on 19/03/2022.
//
//

import Foundation
import CoreData


extension WishListModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishListModel> {
        return NSFetchRequest<WishListModel>(entityName: "WishListModel")
    }

    @NSManaged public var customerID: Int64
    @NSManaged public var productImage: String?
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: String?
    @NSManaged public var productID: Int64

}
