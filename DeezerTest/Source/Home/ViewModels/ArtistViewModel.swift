//
//  ArtistViewModel.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/22/21.
//

import Foundation
import Combine

class ArtistViewModel {
	
	@Published var artist: Artist?
	@Published var artistSearchResults: [HomeControllerCollectionDataWrapper] = []
	@Published var collectionData: [ArtistDetailsCollectionDataWrapper] = []
	@Published var selectedAlbumViewModel: AlbumViewModel?
	@Published var selectedArtistViewModel: ArtistViewModel?
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	private var artistManager: ArtistManager!
	
	init(artistManager: ArtistManager = ArtistManager()) {
		self.artistManager = artistManager
	}
	
	func searchArtist(_ keyword: String) {
		artistManager.searchArtist(keyword: keyword)
			.map({
				return (try? $0.get())?.data ?? []
			})
			.sink { [weak self] result in
				self?.artistSearchResults = result.map({ .artist(artist: $0) })
			}
			.store(in: &cancellables)
	}
	
	func getArtistAlbums() {
		guard let artistId = artist?.id else {
			collectionData = []
			return
		}

		artistManager.getArtistAlbums(artistId)
			.map({
				return (try? $0.get())?.data ?? []
			})
			.sink { [weak self] result in
				self?.collectionData = result.map({ .album(album: $0) })
			}
			.store(in: &cancellables)
	}
	
}
