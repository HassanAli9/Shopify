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
}
