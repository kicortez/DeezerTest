//
//  ArtistAlbumsController.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import UIKit

internal typealias AlbumControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, Int>
internal typealias AlbumControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, Int>

class ArtistAlbumsController: UIViewController {

	private lazy var dataSource: AlbumControllerCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		collectionView.register(cell: ArtistsCollectionCell.self)
		
		return collectionView
	}()
	
	private var artist: Artist?
	
	static func generate(with artist: Artist) -> ArtistAlbumsController {
		let controller = ArtistAlbumsController()
		controller.artist = artist
		
		return controller
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupViews()
		applySnapshot()
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
		snapshot.appendItems([1,2,3,4,5,6,7,8,9,0,11,12,13,14,15,16,17,18,19,20])
		
		dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
    
}

// MARK: - UICollectionView setup
extension ArtistAlbumsController {
	
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
