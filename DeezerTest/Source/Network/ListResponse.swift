//
//  ListResponse.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/21/21.
//

import Foundation

struct ListResponse<T: Decodable>: Decodable {
	let data: [T]
	let total: Int
	let prev: URL?
	let next: URL?
}
