//
//  ArtistAlbumsController.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import UIKit
import Combine

enum ArtistDetailsCollectionDataWrapper: Hashable {
	case album(album: Album)
}

internal typealias AlbumControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, ArtistDetailsCollectionDataWrapper>
internal typealias AlbumControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, ArtistDetailsCollectionDataWrapper>

class ArtistDetailsController: UIViewController {

	private lazy var dataSource: AlbumControllerCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		collectionView.register(cell: ArtistsCollectionCell.self)
		
		return collectionView
	}()
	
	private var artist: Artist?
	private var data: [ArtistDetailsCollectionDataWrapper] = []
	private let artistViewModel: ArtistViewModel = ArtistViewModel()
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	static func generate(with artist: Artist) -> ArtistDetailsController {
		let controller = ArtistDetailsController()
		controller.artist = artist
		
		return controller
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupViews()
		setupSubscribers()
		fetchArtistAlbums()
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		
		setupCollectionView()
	}
	
	private func setupCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		view.pin(collectionView)
	}
	
	private func applySnapshot() {
		var snapshot = AlbumControllerCollectionSnapshot()
		
		// Dummy
		snapshot.appendSections([1])
		snapshot.appendItems(data)
		
		dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
	
	private func setupSubscribers() {
		artistViewModel
			.$artistAlbums
			.sink { [weak self] albums in
				self?.data = albums.map({ .album(album: $0) })
				self?.applySnapshot()
			}
			.store(in: &cancellables)
	}
	
	private func fetchArtistAlbums() {
		guard let artist = artist else {
			return
		}

		artistViewModel.getArtistAlbums(artist.id)
	}
    
}

// MARK: - UICollectionView setup
extension ArtistDetailsController {
	
	private func makeDataSource() -> AlbumControllerCollectionDataSource {
		let source = AlbumControllerCollectionDataSource(collectionView: collectionView, cellProvider: {
			(collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCollectionCell.reuseIdentifier, for: indexPath)
			
			cell.backgroundColor = .tertiarySystemGroupedBackground
			
			return cell
		})
		
		return source
	}
	
	private func makeLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			return self.buildAlbumsLayout()
		}
		
		return layout
	}
																				 
	// MARK: - Artists Layout
	
	private func buildAlbumsLayout() -> NSCollectionLayoutSection? {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
		group.interItemSpacing = .fixed(8.0)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 8.0,
														leading: 16.0,
														bottom: 8.0,
														trailing: 16.0)
		section.interGroupSpacing = 8.0
		
		return section
	}
	
}
