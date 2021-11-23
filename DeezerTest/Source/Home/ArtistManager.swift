//
//  ArtistManager.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/21/21.
//

import Foundation
import Combine

// DataAccessAPI protocol is mainly used as access data, from any source

protocol ArtistDataAccessProtocol: AnyObject {
	func searchArtist(keyword: String) -> AnyPublisher<Result<ListResponse<Artist>, Error>, Never>
	func getArtistInfo(_ artistId: Int) -> AnyPublisher<Result<Artist, Error>, Never>
	func getArtistAlbums(_ artistId: Int) -> AnyPublisher<Result<ListResponse<Album>, Error>, Never>
}

// This class conforms to ArtistDataAccessAPI, and it's implementation accesses artist related content from a server
class ArtistDataAccessAPI: ArtistDataAccessProtocol {
	
	func searchArtist(keyword: String) -> AnyPublisher<Result<ListResponse<Artist>, Error>, Never> {
		return AFAPIManager.request(ArtistService.searchArtist(keyword: keyword))
	}
	
	func getArtistInfo(_ artistId: Int) -> AnyPublisher<Result<Artist, Error>, Never> {
		return AFAPIManager.request(ArtistService.artistInfo(id: artistId))
	}
	
	func getArtistAlbums(_ artistId: Int) -> AnyPublisher<Result<ListResponse<Album>, Error>, Never> {
		return AFAPIManager.request(ArtistService.artistAlbums(artistId: artistId))
	}
	
}

class ArtistManager {
	
	private var dataAccessor: ArtistDataAccessProtocol!
	
	// Allows injection as needed, for instance, if you want to access data from local storage
	init(dataAccessor: ArtistDataAccessProtocol = ArtistDataAccessAPI()) {
		self.dataAccessor = dataAccessor
	}
	
	func searchArtist(keyword: String) -> AnyPublisher<Result<ListResponse<Artist>, Error>, Never> {
		return dataAccessor.searchArtist(keyword: keyword)
	}
	
	func getArtistInfo(_ artistId: Int) -> AnyPublisher<Result<Artist, Error>, Never> {
		return dataAccessor.getArtistInfo(artistId)
	}
	
	func getArtistAlbums(_ artistId: Int) -> AnyPublisher<Result<ListResponse<Album>, Error>, Never> {
		return dataAccessor.getArtistAlbums(artistId)
	}
	
}
