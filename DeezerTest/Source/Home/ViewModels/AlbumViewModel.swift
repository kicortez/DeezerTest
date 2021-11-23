//
//  AlbumViewModel.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import Foundation
import Combine

class AlbumViewModel {

	@Published var album: Album?
	@Published var tracksData: [AlbumDetailsCollectionDataWrapper] = []
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	private var albumManager: AlbumManager!
	
	init(albumManager: AlbumManager = AlbumManager()) {
		self.albumManager = albumManager
	}
	
	func getAlbumTracks() {
		guard let albumId = album?.id else {
			tracksData = []
			return
		}
		
		albumManager.getAlbumTracks(albumId)
			.map({
				return (try? $0.get())?.data ?? []
			})
			.sink { [weak self] result in
				self?.tracksData = result.map({ .track(track: $0) })
			}
			.store(in: &cancellables)
	}
	
}
