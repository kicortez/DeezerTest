//
//  AlbumViewModel.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import Foundation
import Combine

class AlbumViewModel {

	@Published var tracklist: [Track] = []
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	private var albumManager: AlbumManager!
	
	init(albumManager: AlbumManager = AlbumManager()) {
		self.albumManager = albumManager
	}
	
	func getAlbumTracks(_ albumId: Int) {
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
