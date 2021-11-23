//
//  AlbumViewModel+UI.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import Foundation
import UIKit

enum AlbumDetailsCollectionDataWrapper: Hashable {
	case track(track: Track)
}

internal typealias AlbumDetailsCollectionDataSource = UICollectionViewDiffableDataSource<Int, AlbumDetailsCollectionDataWrapper>
internal typealias AlbumDetailsCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, AlbumDetailsCollectionDataWrapper>

// MARK: - AlbumViewModel extension
extension AlbumViewModel {

	func collectionViewCell(_ collectionView: UICollectionView, atIndexPath indexPath: IndexPath, forItemWithIdentifier itemIdentifier: AlbumDetailsCollectionDataWrapper) -> UICollectionViewCell {
		
		switch itemIdentifier {
		case .track(let track):
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionCell.reuseIdentifier, for: indexPath)
			
			if let cell = cell as? TrackCollectionCell {
				cell.configure(with: track.title)
			}
			
			return cell
		}
	}
	
}
