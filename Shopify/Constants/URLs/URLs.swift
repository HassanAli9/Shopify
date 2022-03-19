//
//  URLs.swift
//  Shopify
//
//  Created by Hassan on 14/03/2022.
//

import Foundation

struct URLs{
    
    static let shared = URLs()

    let baseURL = "https://f36da23eb91a2fd4cba11b9a30ff124f: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@jets-ismailia.myshopify.com/admin/api/2022-01/"
    
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
    
     func addressURL(customerId: String) -> URL? {
        return URL(string:  baseURL + "customers/\(customerId)/addresses.json" )


     }
    
}
