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
	@Published var tracklist: [Track] = []
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	private var albumManager: AlbumManager!
	
	init(albumManager: AlbumManager = AlbumManager()) {
		self.albumManager = albumManager
	}
	
	func getAlbumTracks() {
		guard let albumId = album?.id else {
			tracklist = []
			return
		}
		
		albumManager.getAlbumTracks(albumId)
			.map({
				return (try? $0.get())?.data ?? []
			})
			.sink { [weak self] result in
				self?.tracklist = result
			}
			.store(in: &cancellables)
	}
	
}
