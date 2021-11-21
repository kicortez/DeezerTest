//
//  DeezerService.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/21/21.
//

import Foundation

// MARK: - Artists
enum ArtistService: APIService {
	
	case searchArtist(keyword: String)
	case artistInfo(id: Int)
	case artistAlbums(artistId: Int)
	
	var path: String {
		switch self {
		case .searchArtist:
			return "/search/artist"
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
		case .searchArtist(let keyword):
			return ["q": keyword]
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
