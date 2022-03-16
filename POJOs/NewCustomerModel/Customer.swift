/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/
/*import Foundation

struct Customer : Codable {
	let id : Int?
	let email : String?
	let first_name : String?
	let last_name : String?
	let verified_email : Bool?
	let phone : String?
	let tags : String?
	let addresses : [Addresses]?

    init(id: Int?, email: String?, firstName: String?, lastName: String?, verifiedEmail: Bool?, phone: String?, tags: String?, address: [Addresses]?){
        self.id = id
        self.email = email
        self.first_name = firstName
        self.last_name = lastName
        self.verified_email = verifiedEmail
        self.phone = phone
        self.tags = tags
        addresses = address
    }
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case email = "email"
		case first_name = "first_name"
		case last_name = "last_name"
		case verified_email = "verified_email"
		case phone = "phone"
		case tags = "tags"
		case addresses = "addresses"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		verified_email = try values.decodeIfPresent(Bool.self, forKey: .verified_email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		tags = try values.decodeIfPresent(String.self, forKey: .tags)
        addresses = try values.decodeIfPresent([Addresses].self, forKey: .addresses)
	}
}*/
