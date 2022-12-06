//
//  ViewController.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//

import Foundation
struct Currency : Codable {
	let success : Bool?
    let symbols : [String:String]?

	enum CodingKeys: String, CodingKey {

		case success = "success"
		case symbols = "symbols"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		symbols = try values.decodeIfPresent(Dictionary.self, forKey: .symbols)
	}

}
