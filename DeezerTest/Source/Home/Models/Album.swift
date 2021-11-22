//
//  Album.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/22/21.
//

import Foundation

struct Album: Decodable {
	let id: Int
	let title: String
	let coverURL: URL
	
	enum CodingKeys: String, CodingKey {
		case id, title
		case coverURL = "cover_big"
	}
}
