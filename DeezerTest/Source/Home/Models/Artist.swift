//
//  Artist.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/21/21.
//

import Foundation

struct Artist: Decodable {
	let id: Int
	let name: String
	let imageURL: URL
	let position: Int?
	
	enum CodingKeys: String, CodingKey {
		case id, name, position
		case imageURL = "picture_big"
	}
}

extension Artist: Equatable, Hashable {}
