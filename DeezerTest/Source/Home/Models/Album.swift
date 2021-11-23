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
	let releaseDate: String
	
	enum CodingKeys: String, CodingKey {
		case id, title
		case coverURL = "cover_big"
		case releaseDate = "release_date"
	}
}

extension Album: Equatable, Hashable {}

struct AlbumUIModel {
	
	private var album: Album
	
	init(with album: Album) {
		self.album = album
	}
	
	var id: Int {
		return album.id
	}
	
	var title: String {
		return album.title
	}
	
	var coverURL: URL {
		return album.coverURL
	}
	
	var releaseDate: String {
		let date = DateFormatHelper.shared.date(from: album.releaseDate, format: "yyyy-MM-dd")
		
		if let date = date {
			let string = DateFormatHelper.shared.string(from: date, format: "MMM yyyy")
			return "Released \(string)"
		}
		
		return album.releaseDate
	}
	
}
