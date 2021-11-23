//
//  ArtistViewModel+UI.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import Foundation
import UIKit

enum ArtistDetailsCollectionDataWrapper: Hashable {
	case album(album: Album)
}

internal typealias AlbumControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, ArtistDetailsCollectionDataWrapper>
internal typealias AlbumControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, ArtistDetailsCollectionDataWrapper>

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
	
	func didSelectItemWithIdentifier(_ itemIdentifier: ArtistDetailsCollectionDataWrapper) {
		switch itemIdentifier {
		case .album(let album):
			let albumViewModel = AlbumViewModel()
			albumViewModel.album = album
			
			selectedAlbumViewModel = albumViewModel
		}
	}

}
