//
//  ArtistViewModel+UI.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import Foundation
import UIKit

// Can be combined depending on UI
enum ArtistDetailsCollectionDataWrapper: Hashable {
	case album(album: Album)
}

enum HomeControllerCollectionDataWrapper: Hashable {
	case artist(artist: Artist)
}


// MARK: - Diffable data source
internal typealias AlbumControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, ArtistDetailsCollectionDataWrapper>
internal typealias AlbumControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, ArtistDetailsCollectionDataWrapper>

internal typealias HomeControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, HomeControllerCollectionDataWrapper>
internal typealias HomeControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, HomeControllerCollectionDataWrapper>

// MARK: - ArtistViewModel extension
extension ArtistViewModel {
	
	func collectionViewCell(_ collectionView: UICollectionView, atIndexPath indexPath: IndexPath, forItemWithIdentifier itemIdentifier: ArtistDetailsCollectionDataWrapper) -> UICollectionViewCell {
		
		switch itemIdentifier {
		case .album(let album):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionCell.reuseIdentifier, for: indexPath)
			
			if let cell = cell as? AlbumCollectionCell {
				cell.configure(with: album.title, imageURL: album.coverURL)
			}
			
			return cell
		}
	}
	
	func collectionViewCell(_ collectionView: UICollectionView, atIndexPath indexPath: IndexPath, forItemWithIdentifier itemIdentifier: HomeControllerCollectionDataWrapper) -> UICollectionViewCell {
		
		switch itemIdentifier {
		case .artist(let artist):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCollectionCell.reuseIdentifier, for: indexPath)
			
			if let cell = cell as? ArtistsCollectionCell {
				cell.configure(with: artist.name, imageURL: artist.imageURL)
			}
			
			return cell
		}
	}
	
	func didSelectItemWithIdentifier(_ itemIdentifier: ArtistDetailsCollectionDataWrapper) {
		switch itemIdentifier {
		case .album(let album):
			let albumViewModel = AlbumViewModel()
			albumViewModel.album = album
			
			selectedAlbumViewModel = albumViewModel
		}
	}
	
	func didSelectItemWithIdentifier(_ itemIdentifier: HomeControllerCollectionDataWrapper) {
		switch itemIdentifier {
		case .artist(let artist):
			let artistViewModel = ArtistViewModel()
			artistViewModel.artist = artist
			
			selectedArtistViewModel = artistViewModel
		}
	}

}
