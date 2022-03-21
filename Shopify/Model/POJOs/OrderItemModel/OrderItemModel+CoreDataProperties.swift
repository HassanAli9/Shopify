//
//  OrderItemModel+CoreDataProperties.swift
//  
//
//  Created by Nasr on 19/03/2022.
//
//

import Foundation
import CoreData


extension OrderItemModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderItemModel> {
        return NSFetchRequest<OrderItemModel>(entityName: "OrderItemModel")
    }

    @NSManaged public var itemID: Int64
    @NSManaged public var userID: Int64
    @NSManaged public var itemName: String?
    @NSManaged public var itemQuantity: Int64
    @NSManaged public var itemPrice: String?
    @NSManaged public var itemImage: String?

}
