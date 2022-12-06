//
//  ViewController.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import Foundation
struct Query : Codable {
	let amount : Int?
	let from : String?
	let to : String?

	enum CodingKeys: String, CodingKey {

		case amount = "amount"
		case from = "from"
		case to = "to"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		amount = try values.decodeIfPresent(Int.self, forKey: .amount)
		from = try values.decodeIfPresent(String.self, forKey: .from)
		to = try values.decodeIfPresent(String.self, forKey: .to)
	}

}
