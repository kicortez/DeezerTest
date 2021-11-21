//
//  ArtistManager.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/21/21.
//

import Foundation

// DataAccessAPI protocol is mainly used as access data, from any source

protocol ArtistDataAccessAPI: AnyObject {
	func searchArtist(keyword: String, completion: @escaping (Result<ListResponse<Artist>, Error>)->Void)
	func getArtistInfo(_ artistId: Int, completion: @escaping (Result<Artist, Error>)->Void)
}

// This class conforms to ArtistDataAccessAPI, and it's implementation accesses artist related content from a server
class ArtistDataAccessor: ArtistDataAccessAPI {
	
	func searchArtist(keyword: String, completion: @escaping (Result<ListResponse<Artist>, Error>) -> Void) {
		AFAPIManager.request(ArtistService.searchArtist(keyword: keyword)) { result in
			switch result {
			case .success(let data):
				let decoder = JSONDecoder()
				
				do {
					let searchResults = try decoder.decode(ListResponse<Artist>.self, from: data)
					completion(.success(searchResults))
				}
				catch {
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func getArtistInfo(_ artistId: Int, completion: @escaping (Result<Artist, Error>) -> Void) {
		AFAPIManager.request(ArtistService.artistInfo(id: artistId)) { result in
			switch result {
			case .success(let data):
				let decoder = JSONDecoder()
				
				do {
					let artist = try decoder.decode(Artist.self, from: data)
					completion(.success(artist))
				}
				catch {
					completion(.failure(error))
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
}

class ArtistManager {
	
	private var dataAccessor: ArtistDataAccessAPI?
	
	// Allows injection as needed, for instance, if you want to access data from local storage
	init(dataAccessor: ArtistDataAccessAPI = ArtistDataAccessor()) {
		self.dataAccessor = dataAccessor
	}
	
	func searchArtist(keyword: String, completion: @escaping (Result<ListResponse<Artist>, Error>)->Void) {
		dataAccessor?.searchArtist(keyword: keyword, completion: completion)
	}
	
	func getArtistInfo(_ artistId: Int, completion: @escaping (Result<Artist, Error>)->Void) {
		dataAccessor?.getArtistInfo(artistId, completion: completion)
	}
	
}
