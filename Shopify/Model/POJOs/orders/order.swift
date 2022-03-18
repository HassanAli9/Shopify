//
//  order.swift
//  Shopify
//
//  Created by Omar Ahmed on 17/03/2022.
//

import Foundation



//struct CustomerOrder : Codable{
//    var id : Int?
//    var first_name:String?
//    var last_name:String?
//    var order_count:Int?
//}

struct OrderItem : Codable{
    var variant_id : Int?
    var quantity:Int?
    var name:String?
    var price:String?
}


struct Order : Codable{
    var id:Int?
    let customer:Customer?
    var line_items:[OrderItem]?
    var created_at:String?
    var financial_status: String = "PAID"
    var current_total_price:String?
}


struct OrderToAPI : Codable{
    var order : Order
}


struct OrdersToAPI : Codable {
    var orders : [Order]
}
