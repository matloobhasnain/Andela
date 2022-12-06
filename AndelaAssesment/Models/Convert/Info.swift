//
//  ViewController.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import Foundation
struct Info : Codable {
	let rate : Double?
	let timestamp : Int?

	enum CodingKeys: String, CodingKey {

		case rate = "rate"
		case timestamp = "timestamp"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		rate = try values.decodeIfPresent(Double.self, forKey: .rate)
		timestamp = try values.decodeIfPresent(Int.self, forKey: .timestamp)
	}

}
