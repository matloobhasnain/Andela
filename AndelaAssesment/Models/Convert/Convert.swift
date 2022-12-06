//
//  ViewController.swift
//  AndelaAssesment
//
//  Created by Syed Matloob on 06/12/2022.
//
import Foundation
struct Convert : Codable {
	let date : String?
	let info : Info?
	let query : Query?
	let result : Double?
	let success : Bool?

	enum CodingKeys: String, CodingKey {

		case date = "date"
		case info = "info"
		case query = "query"
		case result = "result"
		case success = "success"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		info = try values.decodeIfPresent(Info.self, forKey: .info)
		query = try values.decodeIfPresent(Query.self, forKey: .query)
		result = try values.decodeIfPresent(Double.self, forKey: .result)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
	}

}
