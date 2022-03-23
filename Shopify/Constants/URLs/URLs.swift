//
//  URLs.swift
//  Shopify
//
//  Created by Hassan on 14/03/2022.
//

import Foundation

struct URLs{
    
    static let shared = URLs()

    let baseURL = "https://892d3c2f6c574cc05542710e59d952b4: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@ahmadmazen-5960.myshopify.com/admin/api/2022-01/"
    
    func getAllBrandsURl()-> URL?{
        return URL(string: baseURL + "smart_collections.json")
    }
    
    func getAllProductsInCategories()-> URL?{
        return URL(string: baseURL + "products.json")
    }
    
    func getAllCustomCollections()-> URL?{
        return URL(string: baseURL + "custom_collections.json")
    }
    
    func filterProductsByMainCategory(collectionId : Int)-> URL?{
        return URL(string: baseURL + "products.json?collection_id=\(collectionId)")
    }
    
    func customersURl()-> URL?{
        return URL(string: baseURL + "customers.json")
    }
    func ordersURL()->URL?{
        return URL(string: baseURL + "orders.json")
    }
    
    func allProducts()-> URL?{
        return URL(string: baseURL + "products.json")
    }

    func addAddressToCustomer(id: String) -> URL? {
        return URL(string: baseURL + "customers/\(id).json")
    }
    
    func getOrdersUser(customerId:Int)->URL?{
        return URL(string: baseURL + "customers/\(customerId)/orders.json")
    }
    
}
