//
//  AlbumManager.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/22/21.
//

import Foundation
import Combine

protocol AlbumDataAccessProtocol: AnyObject {
	func getAlbumInfo(_ albumId: Int) -> AnyPublisher<Result<Album, Error>, Never>
	func getAlbumTracks(_ albumId: Int) -> AnyPublisher<Result<ListResponse<Track>, Error>, Never>
}

class AlbumDataAccessAPI: AlbumDataAccessProtocol {
	
	func getAlbumInfo(_ albumId: Int) -> AnyPublisher<Result<Album, Error>, Never> {
		AFAPIManager.request(AlbumService.albumInfo(id: albumId))
	}
	
	func getAlbumTracks(_ albumId: Int) -> AnyPublisher<Result<ListResponse<Track>, Error>, Never> {
		AFAPIManager.request(AlbumService.albumTracks(albumId: albumId))
	}
	
}

class AlbumManager {
	
	private var dataAccessor: AlbumDataAccessProtocol!
	
	// Allows injection as needed, for instance, if you want to access data from local storage
	init(dataAccessor: AlbumDataAccessProtocol = AlbumDataAccessAPI()) {
		self.dataAccessor = dataAccessor
	}
	
	func getAlbumInfo(_ albumId: Int) -> AnyPublisher<Result<Album, Error>, Never> {
		return dataAccessor.getAlbumInfo(albumId)
	}
	
	func getAlbumTracks(_ albumId: Int) -> AnyPublisher<Result<ListResponse<Track>, Error>, Never> {
		return dataAccessor.getAlbumTracks(albumId)
	}
	
}

