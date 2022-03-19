//
//  CustomCollections.swift
//  Shopify
//
//  Created by Omar Ahmed on 15/03/2022.
//

import Foundation

struct Categories : Codable {
    let custom_collections : [Custom_collections]?

    enum CodingKeys: String, CodingKey {

        case custom_collections = "custom_collections"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        custom_collections = try values.decodeIfPresent([Custom_collections].self, forKey: .custom_collections)
    }

}


struct Custom_collections : Codable {
    let id : Int?
    let handle : String?
    let title : String?
    let updated_at : String?
    let body_html : String?
    let published_at : String?
    let sort_order : String?
    let template_suffix : String?
    let published_scope : String?
    let admin_graphql_api_id : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case handle = "handle"
        case title = "title"
        case updated_at = "updated_at"
        case body_html = "body_html"
        case published_at = "published_at"
        case sort_order = "sort_order"
        case template_suffix = "template_suffix"
        case published_scope = "published_scope"
        case admin_graphql_api_id = "admin_graphql_api_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        handle = try values.decodeIfPresent(String.self, forKey: .handle)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        body_html = try values.decodeIfPresent(String.self, forKey: .body_html)
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
        sort_order = try values.decodeIfPresent(String.self, forKey: .sort_order)
        template_suffix = try values.decodeIfPresent(String.self, forKey: .template_suffix)
        published_scope = try values.decodeIfPresent(String.self, forKey: .published_scope)
        admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id)
    }

}
