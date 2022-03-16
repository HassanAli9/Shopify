
import Foundation

struct Image : Codable {
	let created_at : String?
	let alt : String?
	let width : Int?
	let height : Int?
	let src : String?

	enum CodingKeys: String, CodingKey {

		case created_at = "created_at"
		case alt = "alt"
		case width = "width"
		case height = "height"
		case src = "src"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		alt = try values.decodeIfPresent(String.self, forKey: .alt)
		width = try values.decodeIfPresent(Int.self, forKey: .width)
		height = try values.decodeIfPresent(Int.self, forKey: .height)
		src = try values.decodeIfPresent(String.self, forKey: .src)
	}

}
