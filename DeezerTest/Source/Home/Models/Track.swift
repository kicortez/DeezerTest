//
//  Track.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import Foundation

struct Track: Decodable {
	let id: Int
	let title: String
	let previewURL: URL
	let duration: Double
	
	enum CodingKeys: String, CodingKey {
		case id, title, duration
		case previewURL = "preview"
	}
}

extension Track: Equatable, Hashable {}
