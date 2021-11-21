//
//  DeezerService.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/21/21.
//

import Foundation

// MARK: - Artists
enum ArtistService: APIService {
	
	case artistInfo(id: String)
	case artistAlbums(artistId: String)
	
	var path: String {
		switch self {
		case .artistInfo(let id):
			return "/artist/\(id)"
		case .artistAlbums(let artistId):
			return "/artist/\(artistId)/albums"
		}
	}
	
	var method: String {
		switch self {
		default:
			return "get"
		}
	}
	
	var parameters: [String : Any]? {
		switch self {
		default:
			return nil
		}
	}
	
	var header: [String : String]? {
		switch self {
		default:
			return nil
		}
	}
}

// MARK: - Albums
enum AlbumService: APIService {
	
	case albumInfo(id: String)
	case albumTracks(albumId: String)
	
	var path: String {
		switch self {
		case .albumInfo(let id):
			return "/album/\(id)"
		case .albumTracks(let albumId):
			return "/album/\(albumId)/tracks"
		}
	}
	
	var method: String {
		switch self {
		default:
			return "get"
		}
	}
	
	var parameters: [String : Any]? {
		switch self {
		default:
			return nil
		}
	}
	
	var header: [String : String]? {
		switch self {
		default:
			return nil
		}
	}
	
}

// MARK: - Add more services
